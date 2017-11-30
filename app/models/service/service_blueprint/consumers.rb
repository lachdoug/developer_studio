class Service
  class ServiceBlueprint
    class Consumers < ::Blueprint::Section

      # attr_accessor :add_script,
      #               :remove_script,
      #               :update_script
      attr_reader :accepts
                  # :add_script,
                  # :remove_script,
                  # :update_script

      def build_section
        # byebug
        # @add_script = Script.new(( data || {} ).dig :scripts, :add )
        # @remove_script = Script.new(( data || {} ).dig :scripts, :remove )
        # @update_script = Script.new(( data || {} ).dig :scripts, :update )
        #
        # @add_script = ( data || {} ).dig :add_script
        # @remove_script= ( data || {} ).dig :remove_script
        # @update_script= ( data || {} ).dig :update_script
        self.accepts_attributes = accepts_collection_data
      end

      def accepts_collection_data
        ( ( data || {} ).dig( :accepts ) || [] ).map.with_index do |accept, i|
          { i => { type: accept } }
        end.inject(:merge) || {}
      end

      def accepts_attributes=(params)
        @accepts = Accepts.new self, params
      end

      # def add_script_attributes=(params)
      #   @add_script = Script.new(param[:add])
      # end
      #
      # def remove_script_attributes=(params)
      #   @remove_script = Script.new(param[:remove])
      # end
      #
      # def update_script_attributes=(params)
      #   @update_script = Script.new(param[:update])
      # end

      def form_data
        {
          accepts: accepts.map(&:form_data),
        }
      end

    end
  end
end
