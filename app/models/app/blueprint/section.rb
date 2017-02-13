class App
  class Blueprint
    class Section

      # child class should redefine these methods

            def data_location
              []
            end

            def form_data
              {}
            end

            def load_data
              # assign attribtes from persisted data
            end

       # ------------


      include ActiveModel::Model

      def initialize(blueprint)
        @blueprint = blueprint
        load_data
        self
      end

      attr_reader :blueprint

      def save
        valid? && save_updated_blueprint
      end

      def to_label
        "#{app.name} #{data_location.map(&:to_s).join ' '}"
      end

      def persisted_data
        blueprint.content.dig(*data_location)
      end

      # def build(params)
      #   if params.present?
      #     assign_attributes params
      #   else
      #     load_data
      #   end
      # end

      def update(params)
        assign_attributes(params)
        save
      end

      def update_data
        data_location.reverse.
        inject(form_data) { |a, n| { n => a } }
      end

      def updated_blueprint
        blueprint.content.deep_merge(update_data)
      end

      def save_updated_blueprint
        blueprint.update updated_blueprint
      end

      def dropdowns_config
        @dropdowns_config ||= DropdownsConfig.config
      end

      def script_language_collection
        dropdowns_config[:script_languages]
      end


    end
  end
end
