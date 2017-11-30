class Service
  class ServiceBlueprint
    class Consumers
      class Accept < ::Blueprint::SectionNestedCollectionItem

        attr_accessor :type

        def to_s
          type || 'New'
        end

        def form_data
          type
        end

        def dropdowns_config
          @dropdowns_config ||= Settings::DropdownsConfig.config
        end

        def type_collection
          [ 'ManagedEngine', 'ManagedService' ] + dropdowns_config[:type_paths]
        end

      end
    end
  end
end
