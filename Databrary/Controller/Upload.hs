{-# LANGUAGE OverloadedStrings #-}
module Databrary.Controller.Upload
  ( uploadStart
  , uploadChunk
  , testChunk
  ) where

import Control.Exception (bracket)
import Control.Monad ((<=<))
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Class (lift)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Unsafe as BSU
import Data.ByteString.Lazy.Internal (defaultChunkSize)
import Data.Int (Int64)
import Data.Maybe (isJust)
import Data.Word (Word64)
import Foreign.C.Types (CSize(..))
import Foreign.Marshal.Array (allocaArray, peekArray)
import Foreign.Ptr (castPtr)
import Network.HTTP.Types (ok200, noContent204, badRequest400)
import qualified Network.Wai as Wai
import System.IO (SeekMode(AbsoluteSeek))
import System.Posix.Files.ByteString (setFdSize)
import System.Posix.IO.ByteString (openFd, OpenMode(ReadOnly, WriteOnly), defaultFileFlags, exclusive, closeFd, fdSeek, fdWriteBuf, fdReadBuf)
import System.Posix.Types (COff(..))

import Databrary.Has (view, peek, peeks, focusIO)
import qualified Databrary.JSON as JSON
import Databrary.Service.Log
import Databrary.Model.Id
import Databrary.Model.Permission
import Databrary.Model.Volume
import Databrary.Model.Format
import Databrary.Model.Token
import Databrary.Store.Upload
import Databrary.Store.Asset
import Databrary.HTTP.Form.Deform
import Databrary.HTTP.Path.Parser
import Databrary.Action.Response
import Databrary.Action
import Databrary.Controller.Paths
import Databrary.Controller.Form
import Databrary.Controller.Volume

import Control.Monad.IO.Class

fileSizeForm :: DeformActionM f Int64
fileSizeForm = deformCheck "Invalid file size." (0 <) =<< deform

uploadStart :: ActionRoute (Id Volume)
uploadStart = action POST (pathJSON >/> pathId </< "upload") $ \vi -> withAuth $ do
  liftIO $ print "inside of uploadStart..." --DEBUG
  vol <- getVolume PermissionEDIT vi
  liftIO $ print "vol assigned...running form..." --DEBUG
  (filename, size) <- runForm Nothing $ (,)
    <$> ("filename" .:> (deformCheck "File format not supported." (isJust . getFormatByFilename) =<< deform))
    <*> ("size" .:> (deformCheck "File too large." ((maxAssetSize >=) . fromIntegral) =<< fileSizeForm))
  liftIO $ print "creating Upload..." --DEBUG
  tok <- createUpload vol filename size
  liftIO $ print "peeking..." --DEBUG
  file <- peeks $ uploadFile tok
  liftIO $ bracket
    (openFd file WriteOnly (Just 0o640) defaultFileFlags{ exclusive = True })
    closeFd
    (`setFdSize` COff size)
  return $ okResponse [] $ unId (view tok :: Id Token)

chunkForm :: DeformActionM f (Upload, Int64, Word64)
chunkForm = do
  liftIO $ print "inside of chunkForm..." --DEBUG
  csrfForm
  liftIO $ print "chunkForm: ran csrfForm..." --DEBUG
  up <- "flowIdentifier" .:> (lift . (maybeAction <=< lookupUpload) =<< deform)
  liftIO $ print "chunkForm: up assigned..." --DEBUG
  let z = uploadSize up
  "flowFilename" .:> (deformGuard "Filename mismatch." . (uploadFilename up ==) =<< deform)
  "flowTotalSize" .:> (deformGuard "File size mismatch." . (z ==) =<< fileSizeForm)
  liftIO $ print "chunkForm: z assigned..." --DEBUG
  c <- "flowChunkSize" .:> (deformCheck "Chunk size too small." (1024 <=) =<< deform)
  liftIO $ print "chunkForm: c assigned..." --DEBUG
  n <- "flowTotalChunks" .:> (deformCheck "Chunk count mismatch." ((1 >=) . abs . (pred z `div` c -)) =<< deform)
  liftIO $ print "chunkForm: n assigned..." --DEBUG
  i <- "flowChunkNumber" .:> (deformCheck "Chunk number out of range." (\i -> 0 <= i && i < n) =<< pred <$> deform)
  liftIO $ print "chunkForm: i assigned..." --DEBUG
  let o = c * i
  l <- "flowCurrentChunkSize" .:> (deformCheck "Current chunk size out of range." (\l -> (c == l || i == pred n) && o + l <= z) =<< deform)
  liftIO $ print "chunkForm: l assigned..." --DEBUG
  return (up, o, fromIntegral l)

uploadChunk :: ActionRoute ()
uploadChunk = action POST (pathJSON </< "upload") $ \() -> withAuth $ do
  liftIO $ print "inside of uploadChunk..." --DEBUG
  (up, off, len) <- runForm Nothing chunkForm
  liftIO $ print "uploadChunk: truple assigned..." --DEBUG
  file <- peeks $ uploadFile up
  liftIO $ print "uploadChunk: file assigned..." --DEBUG
  let checkLength n
        | n /= len = do
          t <- peek
          focusIO $ logMsg t ("uploadChunk: wrong size " ++ show n ++ "/" ++ show len)
          result $ response badRequest400 [] ("Incorrect content length: file being uploaded may have moved or changed" :: JSON.Value)
        | otherwise = return ()
  bl <- peeks Wai.requestBodyLength
  liftIO $ print "uploadChunk: bl assigned..." --DEBUG
  case bl of
    Wai.KnownLength l -> checkLength l
    _ -> return ()
  rb <- peeks Wai.requestBody
  n <- liftIO $ bracket
    (openFd file WriteOnly Nothing defaultFileFlags)
    closeFd $ \h -> do
    _ <- fdSeek h AbsoluteSeek (COff off)
    liftIO $ print "uploadChunk:  fdSeek..." --DEBUG
    let block n = do
          b <- rb
          if BS.null b
            then return n
            else do
              let n' = n + fromIntegral (BS.length b)
                  write b' = do
                    w <- BSU.unsafeUseAsCStringLen b' $ \(buf, siz) -> fdWriteBuf h (castPtr buf) (fromIntegral siz)
                    if w < fromIntegral (BS.length b')
                      then write $! BS.drop (fromIntegral w) b'
                      else block n'
              if n' > len
                then return n'
                else write b
    block 0
  liftIO $ print "uploadChunk:  running checkLength..." --DEBUG
  checkLength n -- TODO: clear block (maybe wait for calloc)
  liftIO $ print "uploadChunk:  post checkLength..." --DEBUG
  return $ emptyResponse noContent204 []

testChunk :: ActionRoute ()
testChunk = action GET (pathJSON </< "upload") $ \() -> withAuth $ do
  liftIO $ print "inside of testChunk..." --DEBUG
  (up, off, len) <- runForm Nothing chunkForm
  file <- peeks $ uploadFile up
  r <- liftIO $ bracket
    (openFd file ReadOnly Nothing defaultFileFlags)
    closeFd $ \h -> do
    _ <- fdSeek h AbsoluteSeek (COff off)
    allocaArray bufsiz $ \buf -> do
      let block 0 = return False
          block n = do
            r <- fdReadBuf h buf $ n `min` fromIntegral bufsiz
            a <- peekArray (fromIntegral r) buf
            if r == 0
              then return False -- really should be error
              else if any (0 /=) a
                then return True
                else block $! n - r
      block (CSize len)
  return $ emptyResponse (if r then ok200 else noContent204) []
  where
  bufsiz = fromIntegral defaultChunkSize
