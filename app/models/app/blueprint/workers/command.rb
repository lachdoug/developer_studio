class App
  class Blueprint
    class Workers
      class Command

        include ActiveModel::Model

        def initialize(blueprint_section, params)
          @blueprint_section = blueprint_section
          super params
        end

        attr_accessor :index, :new_record, :name, :command
        attr_reader :blueprint_section

        # def to_s
        #   name || 'New'
        # end

        def form_data
          {
            name: name,
            command: command
          }
        end

        def disable_moveup
          index == 0 || new_record
        end

        def update(params)
          assign_attributes params
          blueprint_section.save
        end

      end
    end
  end
end
