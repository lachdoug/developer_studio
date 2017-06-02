class App
  class AppBlueprint
    class Actionator < ::Blueprint::SectionCollectionItem

      attr_accessor :name, :label, :description, :return_type, :return_file_name, :enable_logging
      attr_reader :script

      def script_attributes=(params={})
        @script = Script.new params
        # byebug
      end

      def script
        @script ||= Script.new
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
          return_type: return_type,
          return_file_name: return_file_name,
          enable_logging: ActiveRecord::Type::Boolean.new.cast(enable_logging),
          script: script.form_data,
          variables: variables.map(&:form_data),
        }
      end

      def return_type_collection
        [:none, :plain_text, :markdown, :json, :url, :file]
      end

    end
  end
end
