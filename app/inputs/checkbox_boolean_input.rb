class CheckboxBooleanInput < SimpleForm::Inputs::BooleanInput
  def input(wrapper_options = nil)
    # byebug
    input_html_options[:class] << 'form-control'
    input_html_options[:checked_value] = 'true'
    input_html_options[:unchecked_value] = 'false'
    out = ActiveSupport::SafeBuffer.new
    out << @builder.check_box(attribute_name, input_html_options)
    out
  end
end
