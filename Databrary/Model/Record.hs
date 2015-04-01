{-# LANGUAGE OverloadedStrings, TemplateHaskell, RecordWildCards #-}
module Databrary.Model.Record
  ( module Databrary.Model.Record.Types
  , blankRecord
  , lookupRecord
  , lookupVolumeRecords
  , addRecord
  , changeRecord
  , removeRecord
  , recordJSON
  ) where

import Control.Applicative ((<$>))
import Data.Maybe (catMaybes)

import Databrary.Has (peek, view)
import Databrary.DB
import qualified Databrary.JSON as JSON
import Databrary.Model.SQL
import Databrary.Model.Audit
import Databrary.Model.Id
import Databrary.Model.Identity.Types
import Databrary.Model.Volume.Types
import Databrary.Model.Party.Types
import Databrary.Model.RecordCategory
import Databrary.Model.Measure
import Databrary.Model.Record.Types
import Databrary.Model.Record.SQL

useTPG

blankRecord :: Volume -> Record
blankRecord vol = Record
  { recordId = error "blankRecord"
  , recordVolume = vol
  , recordCategory = Nothing
  , recordConsent = Nothing
  , recordMeasures = []
  }

lookupRecord :: (MonadHasIdentity c m, DBM m) => Id Record -> m (Maybe Record)
lookupRecord ri = do
  ident <- peek
  dbQuery1 $(selectQuery (selectRecord 'ident) "$WHERE record.id = ${ri}")

lookupVolumeRecords :: DBM m => Volume -> m [Record]
lookupVolumeRecords vol =
  dbQuery $ fmap ($ vol) $(selectQuery selectVolumeRecord "$WHERE record.volume = ${volumeId vol}")

addRecord :: MonadAudit c m => Record -> m Record
addRecord br = do
  ident <- getAuditIdentity
  dbQuery1' $(insertRecord 'ident 'br)

changeRecord :: MonadAudit c m => Record -> m ()
changeRecord r = do
  ident <- getAuditIdentity
  dbExecute1' $(updateRecord 'ident 'r)

removeRecord :: MonadAudit c m => Record -> m ()
removeRecord r = do
  ident <- getAuditIdentity
  dbExecute1' $(deleteRecord 'ident 'r)

recordJSON :: Record -> JSON.Object
recordJSON r@Record{..} = JSON.record recordId $ catMaybes
  [ -- Just $ "volume" JSON..= volumeId recordVolume
    ("category" JSON..=) <$> fmap recordCategoryId recordCategory
  , Just $ "measures" JSON..= JSON.Object (measuresJSON $ getRecordMeasures r)
  ]