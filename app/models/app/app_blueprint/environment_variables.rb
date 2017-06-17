class App
  class AppBlueprint
    class EnvironmentVariables < ::Blueprint::SectionCollection

      # def build
      #   super.tap &:build_input
      # end

      def collection_data
        ( data || [] ).map.with_index do |variable_params, i|
          { i => variable_attributes_for(variable_params) }
        end.inject(:merge) || {}
      end

      def variable_attributes_for(variable_params)
        variable_params.map do |k,v|
          if k.to_sym == :input
            variable_input_attributes_for v
          else
            { k => v }
          end
        end.inject(:merge)
      end

      def variable_input_attributes_for(input_params)
        { input_attributes: input_params.map do |k,v|
          if k.to_sym == :validation
            { validation_attributes: v }
          elsif k.to_sym == :collection
            { collection_attributes: v.map do |k,v|
              if k.to_sym == :items
                { items_attributes: v.map.with_index { |item_attributes, i| { i => { value: item_attributes.first, label: item_attributes.last } } }.inject(:merge) || {} }
              else
                { k => v }
              end
            end.inject(:merge) }
          else
            { k => v }
          end
        end.inject(:merge) }
      end

    end
  end
end
