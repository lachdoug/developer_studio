class App
  class Blueprint
    class ServiceConfigurations
      class ServiceConfiguration

        include ActiveModel::Model

        attr_accessor :service_configurations, :namespace, :type_path
        attr_reader :variables

        # def initialize(service_configurations)
        #   @service_configurations = service_configurations
        # end

        def variables_attributes=(params={})
          @variables = params.map { |i, variable_params| Variable.new(service_configuration: self).tap{ |variable| variable.assign_attributes variable_params } }
        end

        def form_data
          {
            namespace: namespace,
            type_path: type_path,
            variables: ( ( variables || [] ).map(&:form_data).inject(:merge) || {} )
          }
        end

        def update(params)
          assign_attributes(params)
          service_configurations.save
          if namespace.present? && type_path.present? && variables.empty? && service_definition_has_consumer_params
            load_variables_from_service_definition
          end
        end

        def load_variables_from_service_definition
          return false unless service_definition_file.present?
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
          variables.map(&:name).map &:to_sym
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
            ( service_definition['consumer_params'] || {} ).deep_symbolize_keys
        end

        def service_definition
          YAML.load(service_definition_file) || {}
        end

        def service_definition_file
          ServiceDefinitions::Group.new( namespace ).service_definition_for(type_path).content
        end

      end
    end
  end
end
