class App
  class AppBlueprint
    class ServiceConfiguration
      class Variable

        include ActiveModel::Model

        attr_accessor :service_configuration, :value
        attr_reader :name

        def to_s
          name
        end

        def name=(name)
          self.class.send(:attr_accessor, "#{name}_confirmation")
          @name = name
        end

        def resolve_strings_collection
          service_configuration.dropdowns_config[:resolve_strings]
        end

        def form_data
          {
            name => value
          }
        end

        def variable_definition
          @variable_definition ||=
          ( service_configuration.service_definition_consumer_params[name.to_sym] || {} )
        end

      end
    end
  end
end
