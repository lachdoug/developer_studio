class Service
  class ServiceBlueprint
    class Configurator < ::Blueprint::SectionCollectionItem

      attr_accessor :name, :label, :description, :enable_logging, :no_save

      def set_script_attributes=(params={})
        @set_script = Script.new params
      end

      def set_script
        @set_script ||= Script.new
      end

      def set_script_sudo_attributes=(params={})
        @set_script_sudo = Script.new params
      end

      def set_script_sudo
        @set_script_sudo ||= Script.new
      end

      def read_script_attributes=(params={})
        @read_script = Script.new params
      end

      def read_script
        @read_script ||= Script.new
      end

      def read_script_sudo_attributes=(params={})
        @read_script_sudo = Script.new params
      end

      def read_script_sudo
        @read_script_sudo ||= Script.new
      end

      def variables
        @variables ||= Variables.new(blueprint_section)
      end

      def variables_attributes=(collection_params)
        @variables = Variables.new(blueprint_section, collection_params)
      end

      def form_data
        {
          name: name,
          label: label,
          description: description,
          enable_logging: cast_as_boolean(enable_logging),
          no_save: cast_as_boolean(no_save),
          set_script: set_script.form_data,
          set_script_sudo: set_script_sudo.form_data,
          read_script: read_script.form_data,
          read_script_sudo: read_script_sudo.form_data,
          variables: variables.map(&:form_data),
        }
      end

      def return_type_collection
        [:none, :plain_text, :markdown, :json, :url, :file]
      end

    end
  end
end
