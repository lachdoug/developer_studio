class App
  class Blueprint
    class Workers
      class Commands

        attr_reader :blueprint_section

        def initialize(blueprint_section, collection_params)
          @blueprint_section = blueprint_section
          set_collection_for collection_params
        end

        def each(&block)
          @collection.each &block
        end

        def find(i)
          i = i.to_i
          @collection[i] || build
        end

        def set_collection_for(collection_params)
          @collection = collection_params.map { |i, item_params| Command.new( blueprint_section, item_params.merge( {index: i} ) ) }
        end

        def build
          Command.new( blueprint_section, {new_record: true, index: @collection.size} ).tap do |item|
            @collection << item
          end
        end

        def delete(i)
          @collection.delete_at i.to_i
          reindex_collection
          blueprint_section.save
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
          blueprint_section.save
        end

      def form_data
        @collection.map(&:form_data)
      end

      end
    end
  end
end
