class App
  class Blueprint
    class ReplacementStrings < Section

      attr_reader :replacement_strings

      def data_location
        [ :software, :replacement_strings ]
      end

      def load_data
        self.replacement_strings_attributes = replacement_strings_persisted_data
      end

      def replacement_strings_persisted_data
        persisted_data.map.with_index do |replacement_string, i|
          { i.to_s => replacement_string }
        end.inject(:merge) || {}
      end

      def replacement_strings_attributes=(params)
        @replacement_strings = params.map { |i, p| App::Blueprint::ReplacementStrings::ReplacementString.new p }
      end

      def build_replacement_string
        @replacement_strings << App::Blueprint::ReplacementStrings::ReplacementString.new
      end

      def form_data
        replacement_strings.map &:form_data
      end

      def delete(i)
        replacement_strings.delete_at i
        save
      end


    end
  end
end
