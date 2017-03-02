module Conform
  class ServiceDefinition
    class Schema_0_0ToSchema_1_0

      def initialize(raw_service)
        @raw_service = raw_service
      end

      def r(*keys)
        @raw_service.dig(*keys)
      end

      def output
        { schema: {
            type: "service",
            version: { major: 1, minor: 0 },
            origin: "n/a"
          },
          metadata: metadata,
          service: service
        }
      end

      def metadata
        {
          service_definition: {
            version: {
              major: 0,
              minor: 0,
              level: 'alpha',
              patch: 0,
            },
            timestamp: nil
          },
          service: {
            display: {
              label: r(:title).to_s,
              description: r(:description).to_s,
              author: r(:author).to_s,
              url: "",
            },
            license: {
              label: "",
              url: "",
            }
          }
        }
      end

      def service
        {
          base: base,
          actionators: actionators,
          configurators: configurators,
          constants: constants,
          target_environment_variables: target_environment_variables,
          consumer_params: consumer_params,
          type_consumer_params: type_consumer_params
        }
      end

      def base
        {
          type_path: r(:type_path).to_s,
          publisher_namespace: r(:publisher_namespace).to_s,
          accepts: r(:accepts),
          service_container: r(:service_container).to_s,
          service_handle_field: r(:service_handle_field).to_s,
          dedicated: r(:dedicated).to_s,
          persistent: r(:persistent).to_s,
          immutable: r(:immutable).to_s,
          attach_post_build: r(:attach_post_build).to_s,
          attach_requires_restart: r(:attach_requires_restart).to_s
        }
      end

      def actionators
        ( r(:actionators) || {} ).values.map do |a|
          service_configuration_for a
        end
      end





      def actionator_variables_for(a)
        ( a.dig(:params) || {}).map do |key, av|
          actionator_variable_for av
        end
      end

      def actionator_variable_for(av)
        {
          name: av.dig(:name).to_s,
          value: av.dig(:value).to_s,
          input: {
            type: variable_field_type_for(av),
            label: av.dig(:label).to_s,
            title: av.dig(:tooltip).to_s,
            hint: av.dig(:hint).to_s,
            placeholder: av.dig(:placeholder).to_s,
            validation: {
              required: cast_boolean_for(av.dig(:mandatory)),
              pattern: av.dig(:regex_validator).to_s,
              message: av.dig(:regex_invalid_message).to_s
            },
            collection: {
              include_blank: false,
              items: variable_collection_items_for(av)
             },
          }
        }
      end

      def variable_collection_items_for(variable)
        vsc = variable.dig(:select_collection)
        return {} if vsc.empty?
        vsc
      end

      def variable_field_type_for(v)
        case v.dig(:field_type).to_sym
        when :boolean
          :boolean
        when :collection, :select, :select_single
          :select
        when :int
          :integer
        when :hidden
          :hidden
        when :password
          :password
        when :password_with_confirmation
          :password_with_confirmation
        when :text, :text_area
          :text
        when :text_field
          :string
        end
      end

      def cast_boolean_for(boolean)
        ActiveRecord::Type::Boolean.new.cast(boolean)
      end

    end
  end
end
