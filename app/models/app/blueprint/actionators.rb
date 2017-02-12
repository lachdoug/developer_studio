class App
  class Blueprint
    class Actionators < Section

      attr_reader :actionators

      def data_location
        [ :software, :actionators ]
      end

      def load_data
        self.actionators_attributes = actionators_persisted_data
      end

      def actionators_persisted_data
        persisted_data.map.with_index do |actionator, i|
          { i.to_s =>
            actionator.map do |k,v|
              if k.to_sym == :script
                { script_attributes: v }
              elsif k.to_sym == :variables
                { variables_attributes: variables_attributes_for(v) }
              else
                { k => v }
              end
            end.inject(:merge) }
        end.inject(:merge) || {}
      end

      def variables_attributes_for(variables_params)
        variables_params.map.with_index do |variable_params, i|
          { i.to_s => variable_attributes_for(variable_params) }
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
                { items_attributes: v.map.with_index { |item_attributes, i| { i.to_s => { value: item_attributes.first, label: item_attributes.last } } }.inject(:merge) || {} }
              else
                { k => v }
              end
            end.inject(:merge) }
          else
            { k => v }
          end
        end.inject(:merge) }
      end

      def actionators_attributes=(params)
        @actionators = params.map { |i, actionator_params| Actionator.new actionator_params }
      end

      def build_actionator
        @actionators << Actionator.new.tap { |actionator| actionator.script_attributes = {} }
      end

      def form_data
        actionators.map &:form_data
      end

      def delete(i)
        actionators.delete_at i
        save
      end

      def find(i)
        actionators[i.to_i] || build_actionator
      end

      def find_actionator_variable(actionator_i, variable_i)
        find(actionator_i.to_i).variables[variable_i.to_i]
      end

      def delete_variable_input_collection_item(actionator_i, variable_i, i)
        find_actionator_variable(actionator_i, variable_i).input.collection.items.delete_at(i.to_i)
        save
      end

    end
  end
end
