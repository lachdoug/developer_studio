class App
  class Blueprint
    class SectionCollectionItem

      include ActiveModel::Model

      def initialize(blueprint_section, params={})
        @blueprint_section = blueprint_section
        super(params)
      end

      attr_accessor :index, :new_record
      attr_reader :blueprint_section

      def self.form_attributes(*attributes)
        attr_accessor *attributes
        define_form_data attributes
      end

      def self.define_form_data(attributes)
        send(:define_method, :form_data) do
          attributes.map do |attribute|
            { attribute => send(attribute) }
          end.inject(:merge)
        end
      end

      def to_s
        name || 'New'
      end

      def update(params)
        assign_attributes params
        blueprint_section.save
      end

      def dropdowns_config
        @dropdowns_config ||= Settings::DropdownsConfig.config
      end

      def script_language_collection
        dropdowns_config[:script_languages]
      end

      def disable_moveup
        index == 0 || new_record
      end

    end
  end
end
