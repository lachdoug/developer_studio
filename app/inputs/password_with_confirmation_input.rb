class PasswordWithConfirmationInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    input_html_options[:class] << 'form-control'
    out = ActiveSupport::SafeBuffer.new
    out << @builder.password_field(attribute_name, input_html_options)
    # out << @builder.password_field("#{attribute_name}_confirmation", input_html_options.merge({label: :hi}))
    out
  end

end
