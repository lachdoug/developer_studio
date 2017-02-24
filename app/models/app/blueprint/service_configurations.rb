class App
  class Blueprint
    class ServiceConfigurations < Section

      def all
        @service_configurations
      end

      def each_with_id
        @service_configurations.each.with_index { |item, i| yield item, i }
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
        @service_configurations = params.map { |i, attributes| ServiceConfiguration.new(service_configurations: self).tap { |item| item.assign_attributes(attributes) } }
      end

      def build
        ServiceConfiguration.new(service_configurations: self).tap do |new_item|
          @service_configurations << new_item
        end
      end

      def form_data
        @service_configurations.map &:form_data
      end

      def find(i)
        @service_configurations[i.to_i] || build
      end

      def delete(i)
        @service_configurations.delete_at i.to_i
        save
      end

    end
  end
end
