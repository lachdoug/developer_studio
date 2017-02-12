class App
  class Blueprint
    class Workers
      class Command

        include ActiveModel::Model

        attr_accessor :command, :name

        def form_data
          { name: name,
            command: command }
        end

      end
    end
  end
end
