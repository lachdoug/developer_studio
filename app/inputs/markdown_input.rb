class MarkdownInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    input_html_options[:class] << 'form-control input-not-viewable'
    input_html_options[:tabindex] = '-1'
    out = ActiveSupport::SafeBuffer.new
    out << markdown_display_area_html(attribute_name)
    out << @builder.text_area(attribute_name, input_html_options)
    out
  end

  def markdown_display_area_html(attribute_name)
    template.content_tag :div, content_tag(:span, template.markdown_text( @builder.object.send(attribute_name) || '' ), class: 'rendered_html click-through-button-text' ),
    tabindex: '0',
    class: 'form-control custom-form-editor-input custom-form-markdown-input-show-simplemde-editor'
  end

end
