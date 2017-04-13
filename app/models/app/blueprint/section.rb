class App
  class Blueprint
    class Section

      # child class should redefine these methods

            # def data_location
            #   []
            # end
            #
            # def form_data
            #   {}
            # end
            #
            # def load_data
            #   # assign attribtes from persisted data
            # end

      # ------------

      def self.form_attributes(*attributes)
        attr_accessor *attributes
        define_form_data attributes
        define_load_data attributes
      end

      def self.define_form_data(attributes)
        send(:define_method, :form_data) do
          attributes.map do |attribute|
            { attribute => send(attribute) }
          end.inject(:merge)
        end
      end

      def self.define_load_data(attributes)
        send(:define_method, :load_data) do
          attributes.each do |attribute|
            instance_variable_set( "@#{attribute}", data.dig(attribute) )
          end
        end
      end

      include ActiveModel::Model

      attr_reader :blueprint

      def initialize(blueprint)
        @blueprint = blueprint
        load_data
        self
      end

      def data_location
        [ :software, self.class.name.split('::').last.underscore.to_sym ]
      end

      def save
        valid? && save_updated_blueprint
      end

      def to_label
        "#{app.name} #{data_location.map(&:to_s).join ' '}"
      end

      def data
        blueprint.content.dig(*data_location)
      end

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
        @dropdowns_config ||= Settings::DropdownsConfig.config
      end

      def script_language_collection
        dropdowns_config[:script_languages]
      end

      def new_record?
        false
      end

    end
  end
end
