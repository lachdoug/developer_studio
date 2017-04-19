class CodeInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    input_html_options[:class] << 'form-control input-not-viewable'
    input_html_options[:tabindex] = '-1'
    out = ActiveSupport::SafeBuffer.new
    out << code_display_area_html(attribute_name)
    out << @builder.text_area(attribute_name, input_html_options)
    out
  end

  def code_display_area_html(attribute_name)
    template.content_tag :pre, @builder.object.send(attribute_name),
    tabindex: '0',
    class: 'form-control custom-form-editor-input custom-form-code-input-show-ace-editor'
  end

end
