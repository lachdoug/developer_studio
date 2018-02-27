class Service
  class ServiceBlueprint
    class EnvironmentVariable
      class Input
        class Collection

          include ActiveModel::Model

          def initialize(blueprint_section, params={})
            @blueprint_section = blueprint_section
            super(params)
          end

          attr_accessor :include_blank
          attr_reader :blueprint_section, :items

          def items
            @items ||= []
          end

          def items_attributes=(params)
            @items = params.map { |i, item_params| Item.new item_params.merge({index: i.to_i}) }
          end

          def build_item
            @items ||= []
            @items << Item.new({new_record: true, index: items.count})
          end

          def form_data
            { items: items.map(&:form_data).inject(:merge) || {},
              include_blank: cast_as_boolean(include_blank) }
          end

          def moveup(i)
            i = i.to_i
            @items[i], @items[i-1] =
              @items[i-1].tap{ |item| item.index = i },
              @items[i].tap{ |item| item.index = i - 1 }
            blueprint_section.save
          end

          def delete(i)
            i = i.to_i
            @items.delete_at i.to_i
            blueprint_section.save
          end

          def cast_as_boolean(value)
            ActiveRecord::Type::Boolean.new.cast(value) == true
          end

        end
      end
    end
  end
end
