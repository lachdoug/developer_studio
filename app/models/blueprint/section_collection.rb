module Blueprint
  class SectionCollection < Section

    include SectionCollectionBase

    def collection_data
      data.map.with_index do |item, i|
        { i => item }
      end.inject(:merge) || {}
    end

    def build_section
      self.collection_attributes = collection_data
    end

  end
end
