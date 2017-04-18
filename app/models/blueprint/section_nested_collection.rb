module Blueprint
  class SectionNestedCollection # < Section

    include SectionCollectionBase

    attr_reader :blueprint_section

    def initialize(blueprint_section, collection_params={})
      @blueprint_section = blueprint_section
      self.collection_attributes = collection_params
    end

    def save
      blueprint_section.save
    end

  end
end
