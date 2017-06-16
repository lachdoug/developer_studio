class App
  class AppBlueprint
    class Components
      class Source < ::Blueprint::SectionNestedCollectionItem

        attr_accessor :label, :url
        attr_reader :install_script

        def install_script_attributes=(params)
          @install_script = InstallScript.new(params)
        end

        def install_script
          @install_script ||= InstallScript.new
        end

        def to_s
          label || 'New'
        end

        def form_data
          {
            label: label,
            url: url,
            install_script: install_script.form_data
          }
        end

        def dropdowns_config
          @dropdowns_config ||= Settings::DropdownsConfig.config
        end

        def script_language_collection
          dropdowns_config[:script_languages]
        end

      end
    end
  end
end
