class App
  class Blueprint
    class Schedules < Section

      def all
        @schedules
      end

      def each_with_id
        @schedules.each.with_index { |item, i| yield item, i }
      end

      def data_location
        [ :software, :schedules ]
      end

      def load_data
        self.schedules_attributes = schedules_persisted_data
      end

      def schedules_persisted_data
        persisted_data.map.with_index do |schedule, i|
          { i.to_s =>
            schedule.map do |k,v|
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

      def schedules_attributes=(params)
        @schedules = params.map { |i, attributes| ServiceConfiguration.new(schedules: self).tap { |item| item.assign_attributes(attributes) } }
      end

      def build
        ServiceConfiguration.new(schedules: self).tap do |new_item|
          @schedules << new_item
        end
      end

      def form_data
        @schedules.map &:form_data
      end

      def find(i)
        @schedules[i.to_i] || build
      end

      def delete(i)
        @schedules.delete_at i.to_i
        save
      end

    end
  end
end
