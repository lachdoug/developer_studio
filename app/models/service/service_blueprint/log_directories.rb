class Service
  class ServiceBlueprint
    class LogDirectories < ::Blueprint::SectionCollection

      def collection_attributes=(collection_params)
        @collection = collection_params.map do |i, item_params|
          item_params = { path: item_params } 
          item_class.new self, item_params.merge({index: i})
        end
      end

    end
  end
end
