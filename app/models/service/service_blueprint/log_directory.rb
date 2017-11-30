class Service
  class ServiceBlueprint
    class LogDirectory < ::Blueprint::SectionCollectionItem

      form_attributes :path

      def form_data
        path
      end

    end
  end
end
