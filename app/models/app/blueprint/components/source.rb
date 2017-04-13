class App
  class Blueprint
    class Components
      class Source

        include ActiveModel::Model

        def initialize(blueprint_section, params)
          @blueprint_section = blueprint_section
          super params
        end

        attr_accessor :index, :new_record, :label, :url
        attr_reader :blueprint_section, :install_script

        def install_script_attributes=(params)
          @install_script = InstallScript.new(params)
        end

        def build_install_script
          @install_script = InstallScript.new
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

        def disable_moveup
          index == 0 || new_record
        end

        def update(params)
          assign_attributes params
          blueprint_section.save
        end

      end
    end
  end
end
