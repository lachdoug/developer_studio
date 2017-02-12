class App
  class Blueprint
    class RakeTasks < Section

      attr_accessor :blocking
      attr_reader :rake_tasks

      def data_location
        [ :software, :rake_tasks ]
      end

      def load_data
        self.rake_tasks_attributes = rake_tasks_persisted_data
      end

      def rake_tasks_persisted_data
        persisted_data.map.with_index do |rake_task, i|
          { i.to_s => rake_task }
        end.inject(:merge) || {}
      end

      def rake_tasks_attributes=(params)
        @rake_tasks = params.map { |i, rake_task_params| RakeTask.new rake_task_params }
      end

      def build_rake_task
        @rake_tasks << RakeTask.new
      end

      def form_data
        rake_tasks.map &:form_data
      end

      def delete(i)
        rake_tasks.delete_at i
        save
      end

    end
  end
end
