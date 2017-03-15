class App
  class Blueprint
    class ServiceConfigurations < Section

      def all
        @collection
      end

      def each_with_id
        @collection.each.with_index { |item, i| yield item, i }
      end

      def data_location
        [ :software, :service_configurations ]
      end

      def load_data
        self.service_configurations_attributes = service_configurations_persisted_data
      end

      def service_configurations_persisted_data
        persisted_data.map.with_index do |service_configuration, i|
          { i.to_s =>
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
        return {} unless variables_params.present?
        variables_params.map.with_index do |kv, i|
          { i.to_i.to_s => { name: kv[0], value: kv[1] } }
        end.inject(:merge)
      end

      def service_configurations_attributes=(params)
        @collection = params.map { |i, attributes| ServiceConfiguration.new(service_configurations: self).tap { |item| item.assign_attributes(attributes) } }
      end

      def build(attributes={})
        ServiceConfiguration.new(attributes.merge({service_configurations: self})).tap do |new_item|
          @collection << new_item
        end
      end

      def form_data
        @collection.map &:form_data
      end

      def find(i)
        @collection[i.to_i]
      end

      def delete(i)
        @collection.delete_at i.to_i
        save
      end

    end
  end
end
