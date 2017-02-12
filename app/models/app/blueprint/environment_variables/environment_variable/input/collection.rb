class App
  class Blueprint
    class EnvironmentVariables
      class EnvironmentVariable
        class Input
          class Collection

            include ActiveModel::Model

            attr_accessor :include_blank
            attr_reader :items

            def items_attributes=(params)
              @items = params.map { |id, item_params| Item.new item_params }
            end

            def build_item
              @items = [] unless @items
              @items << Item.new
            end

            def form_data
              { items: (items || []).map(&:form_data).inject(:merge) || {},
                include_blank: ActiveRecord::Type::Boolean.new.cast(include_blank) }
            end

          end
        end
      end
    end
  end
end
