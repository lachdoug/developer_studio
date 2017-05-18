class App
  class AppBlueprint
    class Workers < ::Blueprint::Section

      attr_accessor :blocking
      attr_reader :commands

      def update(params)
        assign_attributes(params)
        save
      end

      def build_section
        @blocking = ( data || {} ).dig :blocking
        self.commands_attributes = commands_collection_data
      end

      def commands_collection_data
        ( ( data || {} )[:commands] || [] ).map.with_index do |command, i|
          { i => command }
        end.inject(:merge) || {}
      end

      def commands_attributes=(params)
        @commands = Commands.new self, params
      end

      def form_data
        {
          blocking: blocking,
          commands: commands.form_data
        }
      end




      # def item_class
      #   App::Blueprint::Workers::Command
      # end
      #
      # def commands
      #   @collection
      # end
      #
      # def update(params)
      #   assign_attributes(params)
      #   save
      # end
      #
      # def build_section
      #   @blocking = data.dig :blocking
      #   self.collection_attributes = commands_collection_data
      # end
      #
      # def commands_collection_data
      #   data[:commands].map.with_index do |command, i|
      #     { i => command }
      #   end.inject(:merge) || {}
      # end
      #
      # # def commands_attributes=(params)
      # #   @commands = params.map { |i, command_params| Command.new command_params.merge({index: i}) }
      # # end
      # #
      # # def build_command
      # #   @commands << Command.new({index: i})
      # # end
      #

    end
  end
end
