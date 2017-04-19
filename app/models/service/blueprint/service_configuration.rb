class Service
  class Blueprint
    class ServiceConfiguration < ::Blueprint::SectionCollectionItem

      form_attributes :publisher_namespace, :type_path

      def variables
        @variables ||= []
      end

      def variables_attributes=(params)
        @variables =
          params.map do |i, variable_params|
            Variable.new(service_configuration: self).tap do |variable|
              variable.assign_attributes variable_params
            end
          end
      end

      def form_data
        {
          publisher_namespace: publisher_namespace,
          type_path: type_path,
          variables: variables.map(&:form_data).inject(:merge) || {}
        }
      end

      def to_s
        if type_path.present?
          "#{publisher_namespace}/#{type_path}"
        elsif publisher_namespace.present?
          "#{publisher_namespace}"
        else
          "New"
        end
      end

      def service_definition
        @service_definition ||=
        ( YAML.load(service_definition_file) || {} ).deep_symbolize_keys
      end

      def service_definition_file
        Settings::ServiceDefinitionNamespace.new( publisher_namespace ).service_definition_for(type_path).content
      end

      def service_definition_consumer_params_mismatch
        redundant_variable_names.any? || new_variable_names.any?
      end

      def redundant_variable_names
        existing_variable_names - defined_variable_names
      end

      def new_variable_names
        defined_variable_names - existing_variable_names
      end

      def existing_variable_names
        variables.map(&:name).map &:to_sym
      end

      def defined_variable_names
        service_definition_consumer_params_settings.keys
      end

      def service_definition_consumer_params_settings
        @service_definition_consumer_params_settings ||=
          service_definition_consumer_params.map{|k, v| { k => v.slice(:name, :value) } }.inject(:merge) || {}
      end

      def service_definition_consumer_params
        @service_definition_consumer_params ||=
          ( service_definition[:consumer_params] || {} )
      end

      def service_definition_has_consumer_params
        service_definition_consumer_params_settings.present?
      end

      def load_variables
        return false unless service_definition.present?
        remove_redundant_variables
        build_new_variables
        sort_variables_to_match_service_definition
        blueprint_section.save
      end

      def remove_redundant_variables
        redundant_variable_names.each do |redundant_variable_name|
          @variables.delete_if { |variable| variable.name == redundant_variable_name }
        end
      end

      def build_new_variables
        new_variable_names.each do |new_variable_name|
          @variables <<
            Variable.new(service_configuration: self).tap do |variable|
              variable.assign_attributes(
                service_definition_consumer_params_settings[new_variable_name])
            end
        end
      end

      def sort_variables_to_match_service_definition
        @variables =
          defined_variable_names.map do |defined_variable_name|
            @variables.find { |variable| variable.name.to_s == defined_variable_name.to_s }
          end
      end

    end
  end
end
