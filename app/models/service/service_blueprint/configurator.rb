class Service
  class ServiceBlueprint
    class Configurator < ::Blueprint::SectionCollectionItem

      attr_accessor :name, :label, :description, :enable_logging

      def script_attributes=(params={})
        @script = Script.new params
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
