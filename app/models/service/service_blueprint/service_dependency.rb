class Service
  class ServiceBlueprint
    class ServiceDependency < ::Blueprint::SectionCollectionItem

      form_attributes :service_name

      def form_data
        service_name
      end

    end
  end
end
