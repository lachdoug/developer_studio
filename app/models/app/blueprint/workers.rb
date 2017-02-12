class App
  class Blueprint
    class Workers < Section

      attr_accessor :blocking
      attr_reader :commands

      def data_location
        [ :software, :workers ]
      end

      def load_data
        @blocking = persisted_data.dig :blocking
        self.commands_attributes = commands_persisted_data
      end

      def commands_persisted_data
        persisted_data[:commands].map.with_index do |worker, i|
          { i.to_s => worker }
        end.inject(:merge) || {}
      end

      def commands_attributes=(params)
        @commands = params.map { |i, worker_params| Command.new worker_params }
      end

      def build_command
        @commands << Command.new
      end

      def form_data
        {
          blocking: blocking,
          commands: commands.map(&:form_data)
        }
      end

      def delete_command(i)
        commands.delete_at i
        save
      end

    end
  end
end
