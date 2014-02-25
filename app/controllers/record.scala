package controllers

import scala.concurrent.Future
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import play.api._
import          templates.Html
import          Play.current
import          mvc._
import          data._
import play.api.i18n.Messages
import play.api.libs.json
import site._
import dbrary._
import models._

private[controllers] abstract sealed class RecordController extends ObjectController[Record] {
  protected def action(i : models.Record.Id, p : Permission.Value = Permission.VIEW) =
    RequestObject.check(models.Record.get(i)(_), p)

  protected def Action(i : models.Record.Id, p : Permission.Value = Permission.VIEW) =
    SiteAction ~> action(i, p)

  protected def categoryMapping : Mapping[RecordCategory]
  protected def metricMapping : Mapping[Metric[_]]

  protected type MeasureMapping = (Metric[_], Option[String])
  private[this] def measureMapping = Forms.tuple(
    "metric" -> metricMapping,
    "datum" -> Forms.optional(Forms.nonEmptyText)
  )
  type EditMapping = (Option[Option[RecordCategory]], Seq[MeasureMapping])
  type EditForm = Form[EditMapping]
  protected lazy val editForm = Form(Forms.tuple(
    "category" -> OptionMapping(Forms.optional(categoryMapping)),
    "measure" -> Forms.seq(measureMapping)
  ))

  def update(i : models.Record.Id) = Action(i, Permission.EDIT).async { implicit request =>
    val (meas, formin) = RecordHtml.editFormFill
    def bad(form : EditForm) =
      ABadForm[EditMapping](RecordHtml.viewEdit(meas, _), form)
    val form = formin.bindFromRequest
    form.fold(bad _, {
      case (category, data) =>
        request.obj.change(category = category).flatMap { _ =>
        val filled = scala.collection.mutable.Set.empty[Int] // temporary hack to prevent data corruption with duplicate metrics
        def update(metric : Metric[_], datum : Option[String]) : Future[Option[String]] =
          datum.fold[Future[Option[String]]] {
            if (!filled.contains(metric.id.unId))
              request.obj.removeMeasure(metric).map(_ => None)
            else
              macros.Async(None)
          } { value =>
            filled.add(metric.id.unId)
            request.obj.setMeasure(metric, value).map {
              case false => Some("measure.bad")
              case true => None
            }
          }
        macros.Async.map(data, (update _).tupled).flatMap {
        _.zipWithIndex.foldLeft(form) { (form, error) => error match {
          case (None, _) => form
          case (Some(error), i) => form.withError("measure.datum[" + i + "]", error)
        } }.fold(bad _, _ => macros.Async(result(request.obj)))
        } }
      }
    )
  }

  private[controllers] def selectList(target : Slot)(implicit request : SiteRequest[_]) : Future[Seq[(String, String)]] =
    /* ideally we'd remove already used records here */
    target.volume.records().map(_ map { r : Record =>
      (r.id.toString, r.category.fold("")(_.name + ':') + r.ident)
    })

  def add(recordId : Record.Id, containerId : Container.Id, segment : Segment) = Action(recordId, Permission.EDIT).async { implicit request =>
    for {
      so <- Slot.get(containerId, segment)
      s = so.getOrElse(throw NotFoundException)
      _ <- request.obj.addSlot(s)
    } yield (result(request.obj))
  }

  def remove(recordId : Record.Id, containerId : Container.Id, segment : Segment, editRedirect : Boolean = false) = Action(recordId, Permission.EDIT).async { implicit request =>
    for {
      so <- Slot.get(containerId, segment)
      s = so.getOrElse(throw NotFoundException)
      _ <- request.obj.removeSlot(s)
    } yield (
      if (editRedirect) Redirect(controllers.routes.SlotHtml.edit(containerId, segment))
      else result(request.obj)
    )
  }
}

object RecordHtml extends RecordController {
  def view(i : models.Record.Id) = Action(i).async { implicit request =>
    for {
      slots <- request.obj.slots
      _ <- macros.Async.foreach[Slot, Unit](slots, _.records)
      assets <- macros.Async.flatMap[Slot, SlotAsset, Seq[SlotAsset]](slots, _.assets)
    } yield (Ok(views.html.record.view(slots, assets)))
  }

  protected val categoryMapping : Mapping[RecordCategory] =
    Forms.of[RecordCategory.Id]
      .transform[Option[RecordCategory]](RecordCategory.get(_), _.get.id)
      .verifying(Messages("measure.unknown"), _.isDefined)
      .transform(_.get, Some(_))
  protected val metricMapping : Mapping[Metric[_]] =
    Forms.of[Metric.Id]
      .transform[Option[Metric[_]]](Metric.get(_), _.get.id)
      .verifying(Messages("measure.unknown"), _.isDefined)
      .transform(_.get, Some(_))

  private[controllers] def editFormFill(implicit request : Request[_]) : (Seq[Metric[_]], EditForm) = {
    val r = request.obj
    val m = r.measures.list
    val mm = m.map(_.metric)
    val t = r.category.fold[Seq[Metric[_]]](Nil)(_.template).diff(mm)
    (mm ++ t, editForm.fill(
      (
        Some(r.category),
        m.map[MeasureMapping, Seq[MeasureMapping]](m => (m.metric, Some(m.datum))) ++ t.map(_ -> None)
      )
    ))
  }

  private val jsonCategories =
    Html(RecordCategory.getAll.map[JsonRecord, json.JsValue](c => JsonRecord(c.id,
      'name -> c.name,
      'template -> c.template.map(_.id)
    )).toString)

  private val jsonMetrics =
    Html(Metric.getAll.toSeq.map[JsonRecord, json.JsValue](m => JsonRecord(m.id,
      'name -> m.name,
      'dataType -> m.dataType,
      'classification -> m.classification,
      'values -> m.values
    )).toString)

  def viewEdit(meas : Seq[Metric[_]], form : EditForm)(implicit request : Request[_]) =
    views.html.record.edit(request.obj, meas, form, jsonCategories, jsonMetrics)

  def edit(i : models.Record.Id) = Action(i, Permission.EDIT) { implicit request =>
    val (m, f) = editFormFill
    Ok(viewEdit(m, f))
  }

  final class SelectForm(implicit request : SlotHtml.Request[_])
    extends AHtmlForm[SelectForm](
      routes.RecordHtml.slotAdd(request.obj.containerId, request.obj.segment, true),
      f => SlotHtml.viewEdit(recordForm = Some(f))) {
    val record = Field(Forms.optional(Forms.of[models.Record.Id]))
    val category = Field(Forms.optional(categoryMapping))
  }

  def slotAdd(containerId : Container.Id, segment : Segment, editRedirect : Boolean = false) =
    SlotHtml.Action(containerId, segment, Permission.EDIT).async { implicit request =>
      val form = new SelectForm()._bind
      form.record.get.fold {
        for {
          r <- models.Record.create(request.obj.volume, form.category.get)
          _ <- r.addSlot(request.obj)
        } yield (Created(views.html.record.edit(r, form.category.get.fold[Seq[Metric[_]]](Nil)(_.template), editForm.fill((Some(form.category.get), Seq())), jsonCategories, jsonMetrics)))
      } (models.Record.get(_).flatMap(_
        .filter(r => r.checkPermission(Permission.DOWNLOAD) && r.volumeId === request.obj.volumeId)
        .fold {
	  form.record.withError("record.bad").Bad
	} (_.addSlot(request.obj).map { _ =>
	  if (editRedirect)
	    Redirect(controllers.routes.SlotHtml.edit(containerId, segment))
	  else
	    SlotHtml.result(request.obj)
	})))
    }

  def add(v : models.Volume.Id, catID : models.RecordCategory.Id) = VolumeController.Action(v, Permission.EDIT).async { implicit request =>
    val cat = RecordCategory.get(catID)
    models.Record.create(request.obj, cat).map { r =>
      Created(views.html.record.edit(r, cat.fold[Seq[Metric[_]]](Nil)(_.template), editForm.fill((Some(cat), Seq())), jsonCategories, jsonMetrics))
    }
  }
}

object RecordApi extends RecordController {
  def get(i : models.Record.Id) = Action(i).async { implicit request =>
    request.obj.json(request.apiOptions).map(Ok(_))
  }

  private implicit val categoryFormatter : format.Formatter[RecordCategory] = new format.Formatter[RecordCategory] {
    def bind(key : String, data : Map[String, String]) =
      data.get(key).flatMap(RecordCategory.getName(_))
        .toRight(Seq(FormError(key, "measure.unknown", Nil)))
    def unbind(key : String, value : RecordCategory) =
      Map(key -> value.name)
  }
  protected def categoryMapping : Mapping[RecordCategory] = Forms.of[RecordCategory]

  private implicit val metricFormatter : format.Formatter[Metric[_]] = new format.Formatter[Metric[_]] {
    def bind(key : String, data : Map[String, String]) =
      data.get(key).flatMap(Metric.getName(_))
        .toRight(Seq(FormError(key, "measure.unknown", Nil)))
    def unbind(key : String, value : Metric[_]) =
      Map(key -> value.name)
  }
  protected def metricMapping : Mapping[Metric[_]] = Forms.of[Metric[_]]

  private val queryForm = Form(Forms.single(
    "category" -> Forms.optional(categoryMapping)
  ))

  def query(volume : models.Volume.Id) = VolumeController.Action(volume).async { implicit request =>
    queryForm.bindFromRequest.fold(
      new ApiFormException(_).result,
      category =>
        request.obj.records(category).map(l =>
          Ok(JsonArray.map[Record,JsonRecord](_.json)(l)))
    )
  }

  def create(v : models.Volume.Id, catname : Option[String]) = VolumeController.Action(v, Permission.EDIT).async { implicit request =>
    val cat = catname.flatMap(RecordCategory.getName(_))
    models.Record.create(request.obj, cat).map(result(_))
  }
}
