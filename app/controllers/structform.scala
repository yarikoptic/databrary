package controllers

import scala.collection.mutable
import scala.concurrent.Future
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import play.api.data._
import play.api.data.validation._
import play.api.mvc._
import play.api.templates.HtmlFormat

/** This is an alternative to play.api.data.Form that provides more structure and safety.
  * The disadvantage of this class is mutability and less efficiency. */
abstract class StructForm {
  self =>

  /** A field in this form, which should only be used to declare vals. */
  protected final case class Field[T](map : Mapping[T]) {
    private[this] var _name : String = _
    def name : String = _name
    private[StructForm] def name_=(name : String) {
      _name = name
    }
    /** The value of this field, which will be filled in by binding the form. */
    var value : T = _
    def fill(v : T) : Field[T] = {
      value = v
      this
    }

    private[StructForm] lazy val mapping : Mapping[T] = map.withPrefix(name)
    private[StructForm] def bind(data : Map[String,String]) : Option[Seq[FormError]] =
      mapping.bind(data).fold(Some(_), v => { value = v ; None })
    private[StructForm] def unbind = mapping.unbind(value)

    def apply() = self()(_name)
  }

  private[this] def getValFields =
    getClass.getMethods.toIterator
      .filter(f => f.getModifiers == 1 && f.getParameterTypes.isEmpty && f.getTypeParameters.isEmpty && classOf[Field[_]].isAssignableFrom(f.getReturnType))
      .map { f =>
	val name = f.getName
	println(name)
	val field = f.invoke(self).asInstanceOf[Field[_]]
	field.name = name
	field
      }.toSeq
  private[this] lazy val _fields = getValFields

  private[this] var _data : Map[String, String] = Map.empty[String, String]
  private[this] val _errors : mutable.ListBuffer[FormError] = mutable.ListBuffer.empty[FormError]
  private[this] val _constraints : mutable.ListBuffer[Constraint[self.type]] = mutable.ListBuffer.empty[Constraint[self.type]]
  final def hasErrors = _errors.nonEmpty

  protected object _mapping extends Mapping[self.type] {
    val key : String = ""
    val constraints : Seq[Constraint[self.type]] = _constraints
    def bind(data : Map[String,String]) : Either[Seq[FormError], self.type] = {
      val l = _fields.flatMap(_.bind(data))
      if (l.isEmpty)
        Right(self)
      else
        Left(l.flatten)
    }
    def unbind(value : self.type) : (Map[String, String], Seq[FormError]) = {
      val (m, e) = _fields.map(_.unbind).unzip
      (m.fold(Map.empty[String, String])(_ ++ _), e.flatten[FormError])
    }
    val mappings : Seq[Mapping[_]] =
      this +: _fields.flatMap(_.mapping.mappings)
    def withPrefix(prefix : String) : Mapping[self.type] =
      throw new UnsupportedOperationException("StructForm.mapping.withPrefix")
    def verifying(c : Constraint[self.type]*) : Mapping[self.type] = {
      _constraints ++= c
      this
    }
  }

  protected class form(value : Option[self.type] = if (hasErrors) None else Some(self)) extends Form[self.type](_mapping, _data, _errors, value) {
    override def bind(data : Map[String, String]) : Form[self.type] = {
      _data = data
      mapping.bind(data).fold(
	errors => { _errors ++= errors ; new form(None) },
	value => new form(Some(value))
      )
    }
    override def fill(value : self.type) : Form[self.type] = {
      val (data, _) = mapping.unbind(value)
      _data = data
      new form(Some(value))
    }
    override def fillAndValidate(value : self.type) : Form[self.type] = {
      val (data, errors) = mapping.unbind(value)
      _data = data
      _errors.clear
      _errors ++= errors
      new form(Some(value))
    }
    override def withError(error : FormError) : Form[self.type] = {
      _errors += error
      new form(None)
    }
    override def discardingErrors : Form[self.type] = {
      _errors.clear
      this
    }
    /* We change globalErrors to also include errors attached to missing fields, as this is a common bug. */
    override def globalErrors : Seq[FormError] =
      _errors.filter(e => e.key.isEmpty || !_data.contains(e.key))
  }
  def apply() = new form()
  protected def _fill() : self.type = {
    _data = _mapping.unbind(self)._1
    self
  }
  def _bind(implicit request : Request[_]) : self.type = {
    apply().bindFromRequest
    self
  }
}

abstract class FormView[+F <: FormView[F]](val _action : Call) extends StructForm {
  self =>
  def _exception : FormException
  final def orThrow() : self.type = {
    if (hasErrors)
      throw _exception
    self
  }
  override def _bind(implicit request : Request[_]) : self.type = {
    super._bind.orThrow
  }
}

abstract class HtmlFormView[+F <: HtmlFormView[F]](action : Call) extends FormView[F](action) {
  def _view : Future[HtmlFormat.Appendable]
  final def Bad : Future[SimpleResult] = _view.map(Results.BadRequest(_))
  final def Ok : Future[SimpleResult] = _view.map(Results.Ok(_))
  final def _exception = new FormException(new form()) {
    def resultHtml(implicit site : SiteRequest[_]) = Bad
  }
}

class HtmlForm[+F <: HtmlFormView[F]](action : Call, view : F => HtmlFormat.Appendable) extends HtmlFormView[F](action) {
  this : F =>
  final def _view = macros.Async(view(this))
}
class AHtmlForm[+F <: HtmlFormView[F]](action : Call, view : F => Future[HtmlFormat.Appendable]) extends HtmlFormView[F](action) {
  this : F =>
  final def _view = view(this)
}

class ApiForm[F <: ApiForm[F]](action : Call) extends FormView[F](action) {
  final def _exception = new ApiFormException(new form())
}
