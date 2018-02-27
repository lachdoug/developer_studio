module Blueprint
  class SectionNestedCollectionItem

    include SectionCollectionItemBase
    include ActiveModel::Model

    def initialize(collection_enumerator, params)
      @blueprint_section = collection_enumerator.blueprint_section
      super params
    end

    def cast_as_boolean(value)
      ActiveRecord::Type::Boolean.new.cast(value) == true
    end

  end
end
