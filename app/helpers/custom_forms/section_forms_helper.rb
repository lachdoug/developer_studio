module CustomForms
  module SectionFormsHelper

    def custom_form_for(section, opts={})
      simple_form_for(
            section,
            html: { class: 'form-horizontal', autocomplete: :off },
            wrapper: :horizontal_form,
            url: opts[:url],
            namespace: opts[:namespace],
            method: opts[:method] || :put,
            remote: true ) do |f|
              content_tag(:div, style: 'height: 0px; overflow: hidden;') do
                text_field_tag(:fake_input, nil, class: "do_not_autosubmit_form_on_change") +
                password_field_tag(:fake_input, nil, class: "do_not_autosubmit_form_on_change")
              end +
              capture{ yield(f) }
      end
    end

    def ace_editor_template
      content_tag :script, id: "ace-editor-template", type: "text/x-custom-template" do
        content_tag :div, id: "ace-editor-container" do
          content_tag(:div, id: "ace-editor-header") do
            content_tag :div, class: 'ace-editor-header-buttons text-center' do
              content_tag(:div, title: 'Finish edit', class: "btn pull-left ace-editor-ok") do
                content_tag :span, class: 'click-through-button-text' do
                  icon_text 'fa-check', 'OK'
                end
              end +
              content_tag(:div, title: 'Insert resolve string', class: "dropdown pull-left") do
                content_tag(:button, class: "btn btn-custom", data: { toggle: "dropdown" } ) do
                  content_tag(:span, "Insert ") + content_tag(:span, nil, class: "caret")
                end +
                content_tag(:ul, class: "dropdown-menu") do
                  Settings::DropdownsConfig.config[:resolve_strings].map do |resolve_string|
                    content_tag(:li, onclick: "copyResolveStringToAceEditor(this)") do
                      content_tag(:button) do
                        resolve_string
                      end
                    end
                  end.join.html_safe
                end
              end +
              content_tag(:div, title: 'Cancel edit', class: "btn pull-right ace-editor-cancel") do
                content_tag :span, class: 'click-through-button-text' do
                  icon 'fa-times'
                end
              end +
              content_tag(:div, nil, id: 'ace-editor-language-mode-display')
            end
          end +
          content_tag(:div, id: "ace-editor") do
          end
        end
      end
    end

    def simplemde_editor_template
      content_tag :script, id: "simplemde-editor-template", type: "text/x-custom-template" do
        content_tag :div, id: "simplemde-editor-container" do
          content_tag(:div, id: "simplemde-editor-header") do
            content_tag :div, class: 'simplemde-editor-header-buttons' do
              content_tag(:div, title: 'Finish edit', class: "btn simplemde-editor-ok") do
                content_tag :span, class: 'click-through-button-text' do
                  icon_text 'fa-check', 'OK'
                end
              end +
              content_tag(:div, title: 'Cancel edit', class: "btn pull-right simplemde-editor-cancel") do
                content_tag :span, class: 'click-through-button-text' do
                  icon 'fa-times'
                end
              end
            end
          end +
          content_tag(:div, id: "simplemde-editor-wrapper") do
            content_tag(:textarea, id: "simplemde-editor") do
            end
          end
        end
      end
    end

  end
end
