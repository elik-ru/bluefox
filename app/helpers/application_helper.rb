module ApplicationHelper
	def flash_class(level)
	    case level
	        when :notice  then "alert alert-dismissable alert-info"
	        when :success then "alert alert-dismissable alert-success"
	        when :error   then "alert alert-dismissable alert-danger"
	        when :alert   then "alert alert-dismissable alert-warning"
	        when "notice"  then "alert alert-dismissable alert-info"
	        when "success" then "alert alert-dismissable alert-success"
	        when "error"   then "alert alert-dismissable alert-danger"
	        when "alert"   then "alert alert-dismissable alert-warning"            
	    end
	end
	
	def f_errors resource, field
		raw resource.errors.messages[field].join("<br>") if resource.errors.messages[field]
	end
	
	def has_errors resource, field
		"has-error" if resource.errors.messages[field]
	end

	def bform_template title="", value="", error=false, &block
		
		raw '<div class="form-group' + (error ? ' has-error' : '' )+ '">' +
		  '<label for="order_status" class="col-sm-4 control-label">' + title + '</label>' +
			'<div class="col-sm-8">
				' + value + (block_given? ? capture(&block) || ""  : "") + '
			</div>
		</div>'
		
	end	
	def bform_template2 title="", data={}, error=false, &block
		
		raw '<div class="form-group' + (error ? ' has-error' : '' )+ '">' +
		  '<label for="order_status" class="col-sm-4 control-label">' + title + '</label>' +
			'<div class="col-sm-1 control-label text-right">
				' + data[:label1] +  '
			</div>'+
			'<div class="col-sm-3">
				' + data[:value1] +  '
			</div>'+
			'<div class="col-sm-1 control-label text-right">
				' + data[:label2] +  '
			</div>'+
			'<div class="col-sm-3">
				' + data[:value2] +  '
			</div>'+
		'</div>'
		
	end	

	
	def bform_static title="", value="", error=false, &block
		
		raw '<div class="form-group form-group-static' + (error ? ' has-error' : '' )+ '">
		  <label for="order_status" class="col-sm-4 control-label">' + title + '</label>
			<div class="col-sm-8">
				<p class="form-control-static">' + (value || "" ) + (block_given? ? capture(&block) || ""  : "") + '
				</p>
			</div>
		</div>'
		
	end

		

	def bform_text title, object, field , form, options ={}
		bform_template title , '' , object.errors[field].any? do
			form.text_field(field, options.reverse_merge(:class => "form-control")) + f_errors(object, field)
		end
	end

	def bform_password title, object, field , form, options ={}
		bform_template title , '' , object.errors[field].any? do
			form.password_field(field, options.reverse_merge(:class => "form-control")) + f_errors(object, field)
		end
	end
  
	def bform_date title, object, field , form, options ={}
		bform_template title , '' , object.errors[field].any? do
			form.text_field(field, options.reverse_merge(:class => "form-control datepicker", :value => (object[field].strftime("%d.%m.%Y") rescue ""))) + f_errors(object, field)
		end
	end
  
	def bform_select title, object, field , form , select_options
		bform_template title , '' , object.errors[field].any? do
			form.select(field, select_options, {}, :class => "form-control") + f_errors(object, field)
		end
	end

	def bform_chosen title, object, field , form , select_options
		bform_template title , '' , object.errors[field].any? do
			form.select(field, select_options, {}, :class => "form-control chosen-select") + f_errors(object, field)
		end
	end
  
	def bform_multiselect title, object, field , form , select_options , html_options={}
		bform_template title , '' , object.errors[field].any? do
			form.select(field, select_options, {}, html_options.reverse_merge(:multiple => true, :class => "form-control")) + f_errors(object, field)
		end
	end
  
	def bform_radio title, object, field , form
		bform_static title , '' , object.errors[field].any? do
			form.radio_button(field, :class => "form-control") + f_errors(object, field)
		end
	end

	def bform_checkbox title, object, field , form
		bform_template '' , '' , object.errors[field].any? do
			raw "<div class='checkbox'>" + form.check_box(field) + title + f_errors(object, field)+"</div>"
		end
	end

	def bform_textarea title, object, field , form , options ={}
		bform_template title , '' , object.errors[field].any? do
			form.text_area(field, options.reverse_merge(:class => "form-control")) + f_errors(object, field)
		end
	end
  
	def bform_wysiwyg title, object, field , form , options ={}
		bform_template title , '' , object.errors[field].any? do
			form.text_area(field, options.reverse_merge(:class => "form-control wysihtml5")) + f_errors(object, field)
		end
	end
  
	def bform_color title, object, field , form
		bform_template title , '' , object.errors[field].any? do
			form.text_field(field, :class => "form-control colorPicker") + f_errors(object, field)
		end
	end
  
	def bform_file title, object, field , form , &block
		bform_template title , '' , object.errors[field].any? do
			form.file_field(field, :class => "form-control") + f_errors(object, field) + (capture(&block) || "")
		end
	end
  
  def modal_template
    raw '<div id="modal-window" class="modal fade" tabindex="-1">
          <div class="modal-dialog modal-lg">
            <div id="modal-window-content" class="modal-content">	
	       </div></div></div>'
  end
	
  def gi icon
    raw "<span class='glyphicon glyphicon-#{icon}'></span>"
  end
  
  def paginate3000 object
    raw %Q(<div class="paginator_totals panel panel-default">
    <div class="panel-body text-right">
    	<div class="items">#{object.total_count} #{Russian.p(object.total_count,"запись","записи","записей")}</div>
    	<div class="pages">#{object.total_pages} #{Russian.p(object.total_pages,"страница","страницы","страниц")}</div>
    </div>
    </div>) +
    paginate(object, :theme => '3000')
  end

  def paginate3000stats object
    raw %Q(<div class="paginator_totals panel panel-default">
    <div class="panel-body text-right">
    	<div class="items">#{object.total_count} #{Russian.p(object.total_count,"запись","записи","записей")}</div>
    	<div class="pages">#{object.total_pages} #{Russian.p(object.total_pages,"страница","страницы","страниц")}</div>
    </div>
    </div>)
  end
  
  def tabulate number
    number_to_currency(number, unit: "", separator: ",", delimiter: " ")
  end

	
end
