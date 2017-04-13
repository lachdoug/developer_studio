class App
  class Blueprint
    class RequiredModules < Section

      attr_reader :required_modules

      def data_location
        [ :software, :required_modules ]
      end

      def load_data
        self.required_modules_attributes = required_modules_persisted_data
      end

      def required_modules_persisted_data
        persisted_data.map.with_index do |required_module, i|
          { i.to_s => required_module }
        end.inject(:merge) || {}
      end

      def required_modules_attributes=(params)
        @required_modules = params.map { |id, required_module_params| RequiredModule.new required_module_params }
      end

      def build_required_module
        @required_modules << RequiredModule.new
      end

      def form_data
        required_modules.map(&:form_data)
      end

      def delete(i)
        required_modules.delete_at i
        save
      end

      def type_collection
        dropdowns_config[:required_module_types]
      end

    end
  end
end
