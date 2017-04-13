class App
  class Blueprint
    class CustomPhpInis < Section

      attr_reader :custom_php_inis

      def data_location
        [ :software, :custom_php_inis ]
      end

      def load_data
        self.custom_php_inis_attributes = custom_php_inis_persisted_data
      end

      def custom_php_inis_persisted_data
        persisted_data.map.with_index do |custom_php_ini, i|
          { i.to_s => custom_php_ini }
        end.inject(:merge) || {}
      end

      def custom_php_inis_attributes=(params)
        @custom_php_inis = params.map { |id, custom_php_ini_params| CustomPhpIni.new custom_php_ini_params }
      end

      def build_custom_php_ini
        @custom_php_inis << CustomPhpIni.new
      end

      def form_data
        custom_php_inis.map(&:form_data)
      end

      def delete(i)
        custom_php_inis.delete_at i
        save
      end

    end
  end
end
