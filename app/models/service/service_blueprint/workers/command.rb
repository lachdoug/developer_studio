class Service
  class ServiceBlueprint
    class Workers
      class Command < ::Blueprint::SectionNestedCollectionItem

        attr_accessor :name, :command

        def form_data
          {
            name: name,
            command: command
          }
        end

      end
    end
  end
end
