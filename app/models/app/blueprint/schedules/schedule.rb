class App
  class Blueprint
    class Schedules
      class Schedule

        include ActiveModel::Model

        attr_accessor :schedules,
                      :label,
                      :instruction,
                      :actionator_name,
                      :timespec_minute,
                      :timespec_hour,
                      :timespec_day_of_month,
                      :timespec_month,
                      :timespec_day_of_week

        attr_reader :variables

        def variables_attributes=(params={})
          @variables =
            params.map do |i, variable_params|
              Variable.new(schedule: self).tap do |variable|
                variable.assign_attributes variable_params
              end
            end
        end

        def form_data
          {
            label: label,
            timespec: timespec,
            instruction: instruction,
          }.merge form_actionator_data
        end

        def timespec
          {
            minute: timespec_minute,
            hour: timespec_hour,
            day_of_month: timespec_day_of_month,
            month: timespec_month,
            day_of_week: timespec_day_of_week
          }
        end

        def form_actionator_data
          if instruction.to_s == 'action'
            {
              actionator: {
                name: actionator_name,
                params: ( ( variables || [] ).map(&:form_data).inject(:merge) || {} )
              }
            }
          else
            {}
          end
        end

        def update(params)
          assign_attributes(params)
          schedules.save
          if ( instruction.to_s == 'action' ) && actionator_name.present? && variables.empty? && blueprint_actionator_has_variables
            load_variables_from_blueprint_actionator
          end
        end

        def load_variables_from_blueprint_actionator
          return false unless blueprint_actionator.present?
          redundant_variable_names.each do |redundant_variable_name|
            @variables.delete_if { |variable| variable.name == redundant_variable_name }
          end
          new_variable_names.each do |new_variable_name|
            @variables <<
              Variable.new(schedule: self).tap do |variable|
                variable.assign_attributes(
                  blueprint_actionator_variable_defaults[new_variable_name])
              end
          end
          schedules.save
        end

        def existing_variable_names
          variables.map(&:name).map &:to_sym
        end

        def defined_variable_names
          blueprint_actionator_variable_defaults.keys
        end

        def redundant_variable_names
          existing_variable_names - defined_variable_names
        end

        def new_variable_names
          defined_variable_names - existing_variable_names
        end

        def blueprint_actionator_variables_mismatch
          # byebug
          redundant_variable_names.any? || new_variable_names.any?
        end

        def blueprint_actionator_has_variables
          blueprint_actionator_variable_defaults.present?
        end

        def blueprint_actionator_variable_defaults
          # byebug
          @blueprint_actionator_variable_defaults ||=
            blueprint_actionator_variables.map{|v| { v[:name].to_sym => { name: v[:name], value: v[:value] } } }.inject(:merge) || {}
        end

        def blueprint_actionator_variables
          @blueprint_actionator_variables ||=
            ( blueprint_actionator[:variables] || [] )
        end

        def blueprint_actionator
          @blueprint_actionator ||=
          ( schedules.blueprint.content[:software][:actionators] || [] ).find{|actionator| actionator[:name] == actionator_name } || {}
        end

      end
    end
  end
end
