class App
  class AppBlueprint
    class EnvironmentVariable < ::Blueprint::SectionCollectionItem

      form_attributes :name,
                      :value,
                      :mandatory,
                      :immutable,
                      :ask_at_build_time,
                      :build_time_only

      attr_reader :input

      # def new_record?
      #   name.blank?
      # end

      def input_attributes=(params={})
        @input = Input.new blueprint_section, params
      end

      def input
        @input ||= Input.new(blueprint_section) #.tap(&:build_validation).tap(&:build_collection)
      end

      def form_data
        {
          name: name,
          value: value,
          mandatory: cast_as_boolean(mandatory),
          ask_at_build_time: cast_as_boolean(ask_at_build_time),
          build_time_only: cast_as_boolean(build_time_only),
          immutable: cast_as_boolean(immutable),
          input: input.form_data
        }
      end

    end
  end
end
