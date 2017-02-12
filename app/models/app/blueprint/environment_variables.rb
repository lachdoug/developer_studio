class App
  class Blueprint
    class EnvironmentVariables < Section

      attr_reader :environment_variables

      def data_location
        [ :software, :environment_variables ]
      end

      def load_data
        self.environment_variables_attributes = environment_variables_persisted_data
      end

      def environment_variables_persisted_data
        persisted_data.map.with_index do |variable_params, i|
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

      def environment_variables_attributes=(params)
        @environment_variables = params.map { |i, p| App::Blueprint::EnvironmentVariables::EnvironmentVariable.new p }
      end

      def build_environment_variable
        App::Blueprint::EnvironmentVariables::EnvironmentVariable.new.tap(&:build_input).tap do |v|
          @environment_variables << v
        end
      end

      def form_data
        environment_variables.map &:form_data
      end

      def delete(i)
        environment_variables.delete_at i
        save
      end

      def delete_input_collection_item(environment_variable_i, collection_item_i)
        find(environment_variable_i.to_i).input.collection.items.delete_at(collection_item_i.to_i)
        save
      end

      def find(i)
        environment_variables[i.to_i] || build_environment_variable
      end

    end
  end
end
