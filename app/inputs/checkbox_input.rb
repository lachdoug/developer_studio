class CheckboxInput < SimpleForm::Inputs::BooleanInput
  # def input(wrapper_options = nil)
  #   # byebug
  #   input_html_options[:class] << 'form-control'
  #   input_html_options[:checked_value] = object.variable_definition[:value] || '1'
  #   input_html_options[:unchecked_value] = ''
  #   out = ActiveSupport::SafeBuffer.new
  #   out << @builder.check_box(attribute_name, input_html_options)
  #   out
  # end

  def input(wrapper_options = nil)
    input_html_options[:checked_value] = input_html_options[:default_value]
    input_html_options[:unchecked_value] = ''

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    if nested_boolean_style?
      build_hidden_field_for_checkbox +
        template.label_tag(nil, class: SimpleForm.boolean_label_class) {
          build_check_box_without_hidden_field(merged_input_options) +
            inline_label
        }
    else
      build_check_box(unchecked_value, merged_input_options)
    end
  end

end
