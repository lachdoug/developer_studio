class App
  class Blueprint
    class RakeTasks
      class RakeTask

        include ActiveModel::Model

        attr_accessor :action, :always_run

        def form_data
          { action: action,
            always_run: ActiveRecord::Type::Boolean.new.cast(always_run) }
        end

      end
    end
  end
end
