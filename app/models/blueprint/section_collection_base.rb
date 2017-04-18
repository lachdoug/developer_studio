module Blueprint
  module SectionCollectionBase

    def item_class
      *parents, name = self.class.name.split('::')
      ( parents << name.singularize ).join('::').constantize
    end

    def build(params={})
      item_class.new( self, {new_record: true, index: @collection.count}.merge(params) ).tap do |item|
        @collection << item
      end
    end

    def collection_attributes=(collection_params)
      @collection = collection_params.map { |i, item_params| item_class.new self, item_params.merge({index: i}) }
    end

    def all
      @collection
    end

    def last
      @collection.last
    end

    def find(i)
      i = i.to_i
      @collection[i] || build
    end

    def each(&block)
      @collection.each &block
    end

    def map(&block)
      @collection.map &block
    end

    def select(&block)
      @collection.select(&block)
    end

    def empty?
      @collection.empty?
    end

    def count
      @collection.count
    end

    def form_data
      @collection.map &:form_data
    end

    def delete(i)
      @collection.delete_at i.to_i
      reindex_collection
      save
    end

    def reindex_collection
      @collection.each.with_index do |item, i|
        item.index = i
      end
    end

    def moveup(index)
      i = index.to_i
      @collection[i], @collection[i-1] =
        @collection[i-1].tap{ |item| item.index = i },
        @collection[i].tap{ |item| item.index = i - 1 }
      save
    end

  end
end
