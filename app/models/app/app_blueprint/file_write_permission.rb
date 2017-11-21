class App
  class AppBlueprint
    class FileWritePermission < ::Blueprint::SectionCollectionItem

      form_attributes :path, :recursive

      def form_data
        {
          path: path,
          recursive: cast_as_boolean(recursive)
        }
      end

    end
  end
end
