class App
  class Blueprint
    class ServiceConfigurations
      class ServiceConfiguration

        include ActiveModel::Model

        attr_accessor :service_configurations, :publisher_namespace, :type_path

        def to_label
          if type_path.present?
            "#{publisher_namespace}/#{type_path}"
          elsif publisher_namespace.present?
            "#{publisher_namespace}"
          else
            "New"
          end
        end

        def variables
          @variables ||= []
        end

        # def new_record?
        #   @new_record
        # end

        def variables_attributes=(params={})
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
            variables: ( ( variables || [] ).map(&:form_data).inject(:merge) || {} )
          }
        end

        def update(params)
          assign_attributes(params)
          service_configurations.save
          if publisher_namespace.present? && type_path.present? && service_definition_has_consumer_params && variables.nil?
            load_variables_from_service_definition
          end
        end

        def load_variables_from_service_definition
          return false unless service_definition.present?
          redundant_variable_names.each do |redundant_variable_name|
            @variables.delete_if { |variable| variable.name == redundant_variable_name }
          end
          new_variable_names.each do |new_variable_name|
            @variables <<
              Variable.new(service_configuration: self).tap do |variable|
                variable.assign_attributes(
                  service_definition_consumer_params_settings[new_variable_name])
              end
          end
          service_configurations.save
        end

        def existing_variable_names
          ( variables || []).map(&:name).map &:to_sym
        end

        def defined_variable_names
          service_definition_consumer_params_settings.keys
        end

        def redundant_variable_names
          existing_variable_names - defined_variable_names
        end

        def new_variable_names
          defined_variable_names - existing_variable_names
        end

        def service_definition_consumer_params_mismatch
          redundant_variable_names.any? || new_variable_names.any?
        end

        def service_definition_has_consumer_params
          service_definition_consumer_params_settings.present?
        end

        def service_definition_consumer_params_settings
          @service_definition_consumer_params_settings ||=
            service_definition_consumer_params.map{|k, v| { k => v.slice(:name, :value) } }.inject(:merge) || {}
        end

        def service_definition_consumer_params
          @service_definition_consumer_params ||=
            ( service_definition[:consumer_params] || {} )
        end

        def service_definition
          # byebug
          ( YAML.load(service_definition_file) || {} ).deep_symbolize_keys
        end

        def service_definition_file
          Settings::ServiceDefinitionNamespace.new( publisher_namespace ).service_definition_for(type_path).content
        end

      end
    end
  end
end
