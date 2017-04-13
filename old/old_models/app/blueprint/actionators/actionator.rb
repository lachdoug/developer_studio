class App
  class Blueprint
    class Actionators
      class Actionator

        include ActiveModel::Model

        attr_accessor :name, :label, :description, :return_type, :return_file_name, :enable_logging
        attr_reader :script, :variables

        def to_label
          if name.present?
            name
          else
            "New"
          end
        end

        def script_attributes=(params)
          @script = Script.new(params)
        end

        def variables_attributes=(params)
          @variables = params.map { |i, p| Variable.new p }
        end

        def build_variable
          @variables = [] if @variables.nil?
          Variable.new.tap(&:build_input).tap do |v|
            @variables << v
          end
        end


        def form_data
          {
            name: name,
            label: label,
            description: description,
            return_type: return_type,
            return_file_name: return_file_name,
            enable_logging: ActiveRecord::Type::Boolean.new.cast(enable_logging),
            script: script.form_data,
            variables: ( variables || [] ).map(&:form_data),
          }
        end

        def return_type_collection
          [:none, :plain_text, :markdown, :json, :url, :file]
        end

      end
    end
  end
end
