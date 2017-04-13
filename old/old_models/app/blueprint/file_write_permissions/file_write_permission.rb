class App
  class Blueprint
    class FileWritePermissions
      class FileWritePermission

        include ActiveModel::Model

        attr_accessor :path, :recursive

        def form_data
          { path: path,
            recursive: ActiveRecord::Type::Boolean.new.cast(recursive) }
        end

      end
    end
  end
end
