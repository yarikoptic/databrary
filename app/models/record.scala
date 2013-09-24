package models

import java.sql.{Timestamp,Date}
import anorm._
import anorm.SqlParser.scalar
import dbrary._
import dbrary.Anorm._
import util._

/** A set of Measures. */
final class Record private (val id : Record.Id, val volume : Volume, val category_ : Option[RecordCategory] = None, val consent : Consent.Value = Consent.NONE) extends TableRowId[Record] with SitePage with InVolume {
  private[this] var _category = category_
  def category : Option[RecordCategory] = _category
  def categoryId = category.map(_.id)

  /** Update the given values in the database and this object in-place. */
  def change(category : Option[RecordCategory] = _category)(implicit db : Site.DB) : Unit = {
    if (category == _category)
      return
    SQL("UPDATE record SET category = {category} WHERE id = {id}").
      on('id -> id, 'category -> category.map(_.id)).execute()
    _category = category
  }

  /** A specific measure of the given type and metric. */
  def measure[T](metric : MetricT[T])(implicit db : Site.DB) : Option[T] = MeasureT.get[T](this.id, metric)
  private[this] val _measures = CachedVal[Seq[Measure], Site.DB](Measure.getRecord(this.id)(_))
  /** All measures in this record. Cached. */
  def measures(implicit db : Site.DB) : Seq[Measure] = _measures

  /** Add or change a measure on this record.
    * This is not type safe so may generate SQL exceptions, and may invalidate measures on this object. */
  def setMeasure(metric : Metric, value : String)(implicit db : Site.DB) = Measure(id, metric, value).set
  /** Remove a measure from this record.
    * This may invalidate measures on this object. */
  def deleteMeasure(metric : Metric)(implicit db : Site.DB) = Measure.delete(id, metric)

  private val _ident = CachedVal[Option[String], Site.DB](measure(Metric.Ident)(_))
  /** Cached version of `measure(Metric.Ident)`.
    * This may become invalid if the value is changed. */
  def ident(implicit db : Site.DB) : Option[String] = _ident

  private val _birthdate = CachedVal[Option[Date], Site.DB](measure(Metric.Birthdate)(_))
  /** Cached version of `measure(Metric.Birthdate)`.
    * This may become invalid if the value is changed. */
  def birthdate(implicit db : Site.DB) : Option[Date] = _birthdate

  private val _daterange = CachedVal[Range[Date], Site.DB] { implicit db =>
    SQL("SELECT record_daterange({id})").
      on('id -> id).single(scalar[Range[Date]](PGDateRange.column))
  }
  /** The range of acquisition dates covered by associated slots. Cached. */
  def daterange(implicit db : Site.DB) : Range[Date] = _daterange.normalize

  /** The range of ages as defined by `daterange - birthdate`. */
  def agerange(implicit db : Site.DB) : Option[Range[Long]] = birthdate.map(dob => daterange.map(_.getTime - dob.getTime))

  /** The age at test for a specific date, as defined by `date - birthdate`. */
  def age(date : Date)(implicit db : Site.DB) : Option[Long] = birthdate.map(date.getTime - _.getTime)

  /** Effective permission the site user has over a given metric in this record, specifically in regards to the measure datum itself.
    * Record permissions depend on volume permissions, but can be further restricted by consent levels.
    */
  def dataPermission(metric : Metric)(implicit site : Site) : Permission.Value =
    Permission.data(volume.permission, consent, metric.classification)

  /** The set of slots to which this record applies. */
  def slots(implicit db : Site.DB) : Seq[Slot] =
    Slot.volumeRow(volume).SQL("JOIN slot_record ON slot.id = slot_record.slot WHERE slot_record.record = {record} ORDER BY slot.source, slot.segment").
    on('record -> id).list
  /** Attach this record to a slot. */
  def addSlot(s : Slot)(implicit db : Site.DB) = Record.addSlot(id, s.id)

  def pageName(implicit site : Site) = ident.orElse(category.map(_.name)).getOrElse("record")
  def pageParent(implicit site : Site) = Some(volume)
  def pageURL = controllers.routes.Record.view(volume.id, id).url
}

object Record extends TableId[Record]("record") {
  private[models] def make(volume : Volume, category : Option[RecordCategory])(id : Id, consent : Option[Consent.Value]) =
    new Record(id, volume, category, consent.getOrElse(Consent.NONE))
  private val columns = Columns[
    Id,  Option[Consent.Value]](
    'id, SelectAs("record_consent(record.id)", "record_consent"))
  private val catCols = columns.leftJoin(RecordCategory.row, "record.category = record_category.id")
  private[models] val row = catCols.join(Volume.row, "record.volume = volume.id") map {
    case (rec ~ cls ~ vol) => (make(vol, cls) _).tupled(rec)
  }
  private[models] def volumeRow(vol : Volume) = catCols map {
    case (rec ~ cls) => (make(vol, cls) _).tupled(rec)
  }
  private[models] def volCatRow(vol : Volume, category : Option[RecordCategory] = None) =
    category.fold(volumeRow(vol))(cat => columns.map(make(vol, Some(cat)) _))

  /** Retrieve a specific record by id. */
  def get(id : Id)(implicit site : Site) : Option[Record] =
    row.SQL("WHERE record.id = {id}").
      on('id -> id, 'identity -> site.identity.id).singleOpt

  /** Retrieve the set of records on the given slot. */
  private[models] def getSlot(slot : Slot)(implicit db : Site.DB) : Seq[Record] =
    volumeRow(slot.volume).SQL("JOIN slot_record ON record.id = slot_record.record WHERE slot_record.slot = {slot}").
      on('slot -> slot.id).list

  /** Retrieve all the categorized records associated the given volume.
    * @param category restrict to the specified category, or include all categories
    * @return records sorted by category, ident */
  private[models] def getVolume(volume : Volume, category : Option[RecordCategory] = None)(implicit db : Site.DB) : Seq[Record] = {
    val metric = Metric.Ident
    val mtyp = metric.measureType
    val cols = volCatRow(volume, category).leftJoin(mtyp.column, "record.id = " + mtyp.table + ".record") map
      { case (record ~ ident) =>
        record._ident() = ident
        record
      }
    cols.SQL("WHERE measure_text.metric = {metric} AND record.volume = {volume}",
        (if (category.isDefined) "AND record.category = {category}" else ""),
        "ORDER BY " + (if (category.isEmpty) "record.category, " else ""),
        metric.measureType.column.select + ", record.id").
      on('volume -> volume.id, 'metric -> metric.id, 'category -> category.map(_.id)).
      list
  }

  /** Create a new record, initially unattached. */
  def create(volume : Volume, category : Option[RecordCategory] = None)(implicit db : Site.DB) : Record = {
    val args = SQLArgs('volume -> volume.id, 'category -> category.map(_.id))
    val id = SQL("INSERT INTO record " + args.insert + " RETURNING id").
      on(args : _*).single(scalar[Id])
    new Record(id, volume, category)
  }

  private[models] def addSlot(r : Record.Id, s : Slot.Id)(implicit db : Site.DB) : Unit = {
    val args = SQLArgs('record -> r, 'slot -> s)
    SQL("INSERT INTO slot_record " + args.insert).on(args : _*).execute
  }
  private[models] def removeSlot(r : Record.Id, s : Slot.Id)(implicit db : Site.DB) : Unit = {
    val args = SQLArgs('record -> r, 'slot -> s)
    SQL("DELETE FROM slot_record WHERE " + args.where).on(args : _*).execute
  }
}
