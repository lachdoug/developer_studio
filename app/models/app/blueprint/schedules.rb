class App
  class Blueprint
    class Schedules < SectionCollection


      def collection_data
        data.map.with_index do |schedule, i|
          { i =>
            { label: schedule[:label],
              timespec_minute: schedule.dig(:timespec, :minute),
              timespec_hour: schedule.dig(:timespec, :hour),
              timespec_day_of_month: schedule.dig(:timespec, :day_of_month),
              timespec_month: schedule.dig(:timespec, :month),
              timespec_day_of_week: schedule.dig(:timespec, :day_of_week),
              instruction: schedule[:instruction],
              actionator_name: schedule.dig(:actionator, :name),
              variables_attributes: variables_attributes_for( schedule.dig(:actionator, :params) )
            }
          }
        end.inject(:merge) || {}
      end

      def variables_attributes_for(variables_params)
        return {} unless variables_params.present?
        variables_params.map.with_index do |kv, i|
          { i => { name: kv[0], value: kv[1] } }
        end.inject(:merge)
      end

    end
  end
end
