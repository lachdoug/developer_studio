class Service
  class ServiceBlueprint
    class FilePermission < ::Blueprint::SectionCollectionItem

      form_attributes :path,
                      :recursive,
                      :user,
                      :group,
                      :permissions,
                      :create

      def to_s
        path || 'New'
      end

      def form_data
        {
          path: path,
          recursive: recursive,
          user: user,
          group: group,
          permissions: permissions,
          create: create,
        }
      end

    end
  end
end
