class Service
  class ServiceBlueprint
    class Configurator
      class Variable
        class Input
          class Collection

            include ActiveModel::Model

            attr_accessor :include_blank
            attr_reader :blueprint_section

            def initialize(blueprint_section, params={})
              @blueprint_section = blueprint_section
              super params
            end

            def items
              @collection ||= []
            end

            def items_attributes=(params)
              @collection = params.map { |i, item_params| Item.new item_params.merge({index: i.to_i}) }
            end

            def build
              Item.new({new_record: true, index: items.size}).tap do |item|
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
              { items: items.map(&:form_data).inject(:merge) || {},
                include_blank: ActiveRecord::Type::Boolean.new.cast(include_blank) }
            end

          end
        end
      end
    end
  end
end
