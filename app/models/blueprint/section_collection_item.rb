module Blueprint
  class SectionCollectionItem

    include SectionCollectionItemBase
    include ActiveModel::Model

    def initialize(blueprint_section, params={})
      @blueprint_section = blueprint_section
      super(params)
    end

    def self.form_attributes(*attributes)
      attr_accessor *attributes
      define_form_data attributes
    end

    def self.define_form_data(attributes)
      send(:define_method, :form_data) do
        attributes.map do |attribute|
          { attribute => send(attribute) }
        end.inject(:merge).delete_if { |k,v| v.blank? }
      end
    end

    def dropdowns_config
      @dropdowns_config ||= Settings::DropdownsConfig.config
    end

    def script_language_collection
      dropdowns_config[:script_languages]
    end

    def cast_as_boolean(value)
      ActiveRecord::Type::Boolean.new.cast(value) == true
    end

  end
end
