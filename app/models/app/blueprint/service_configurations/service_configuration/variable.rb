class App
  class Blueprint
    class ServiceConfigurations
      class ServiceConfiguration
        class Variable

          include ActiveModel::Model

          attr_accessor :service_configuration, :resolve_string, :resolve
          attr_reader :name, :value

          def name=(name)
            self.class.send(:attr_accessor, "#{name}_confirmation")
            @name = name
          end

          def value=(value)
            if value.present? && test_for_resolve_regex.match(value)
              @resolve = '1'
              @resolve_string =  value
            else
              @value = value
            end
          end

          def test_for_resolve_regex
            /^.*(_Engines_System|_Engines_Builder|_Engines_Environment)\(.*\).*/
          end

          def form_data
            {
              name => form_data_value
            }
          end

          def form_data_value
            return resolve_string if test_for_resolve_regex.match(value)
            return ActiveRecord::Type::Boolean.new.cast(value) if type.to_sym == :boolean
            value
          end

          def type
            variable_definition.dig(:input, :type) || field_type_for( variable_definition[:field_type] )
          end

          def collection
            variable_definition.dig(:input, :collection) || collection_for( variable_definition[:select_collection] )
          end

          def label
            variable_definition[:label]
          end

          def title
            variable_definition.dig(:input, :title) || variable_definition[:title]
          end

          def hint
            variable_definition.dig(:input, :hint) || variable_definition[:hint]
          end

          def placeholder
            variable_definition.dig(:input, :placeholder) || variable_definition[:placeholder]
          end

          def variable_definition
            @variable_definition ||=
            service_configuration.service_definition_consumer_params[name.to_sym]
          end

          # Convert schema v0 service definition field types to v1 fields types
          def field_type_for(field_type)
            case field_type.to_sym
            when :boolean
              :boolean
            when :collection, :select, :select_single
              :select
            when :int
              :integer
            when :hidden
              :string
            when :password
              :string
            when :password_with_confirmation
              :string
            when :text, :text_area
              :text
            when :text_field
              :string
            else
              :string
            end
          end

          def collection_for(select_collection)
            return [] unless variable_definition[:select_collection].present?
            JSON.parse(variable_definition[:select_collection])
          rescue
            [variable_definition[:select_collection]]
          end


        end
      end
    end
  end
end
