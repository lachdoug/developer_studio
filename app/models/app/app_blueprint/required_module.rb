class App
  class AppBlueprint
    class RequiredModule < ::Blueprint::SectionCollectionItem

      form_attributes :type, :os_package, :name

      def type_collection
        dropdowns_config[:required_module_types]
      end

    end
  end
end
