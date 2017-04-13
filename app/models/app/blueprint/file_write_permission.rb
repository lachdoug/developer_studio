class App
  class Blueprint
    class FileWritePermission < SectionCollectionItem

      form_attributes :path, :recursive

      def form_data
        { path: path,
          recursive: ActiveRecord::Type::Boolean.new.cast(recursive) }
      end

    end
  end
end
