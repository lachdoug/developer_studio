class App
  class Blueprint
    class ServiceConfigurations < SectionCollection


      def collection_data
        data.map.with_index do |service_configuration, i|
          { i =>
            service_configuration.map do |k,v|
              if k.to_sym == :variables
                { variables_attributes: variables_attributes_for(v) }
              else
                { k => v }
              end
            end.inject(:merge) }
        end.inject(:merge) || {}
      end

      def variables_attributes_for(variables_params)
        # return {} unless variables_params.present?
        variables_params.map.with_index do |kv, i|
          { i => { name: kv[0], value: kv[1] } }
        end.inject(:merge) || {}
      end

      # def load_variables_for(i)
      #   i = i.to_i
      #   find(i).load_variables && save
      # end

    end
  end
end
