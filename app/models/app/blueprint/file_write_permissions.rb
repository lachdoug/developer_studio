class App
  class Blueprint
    class FileWritePermissions < Section

      attr_accessor :blocking
      attr_reader :file_write_permissions

      def data_location
        [ :software, :file_write_permissions ]
      end

      def load_data
        self.file_write_permissions_attributes = file_write_permissions_persisted_data
      end

      def file_write_permissions_persisted_data
        persisted_data.map.with_index do |file_write_permission, i|
          { i.to_s => file_write_permission }
        end.inject(:merge) || {}
      end

      def file_write_permissions_attributes=(params)
        @file_write_permissions = params.map { |i, file_write_permission_params| FileWritePermission.new file_write_permission_params }
      end

      def build_file_write_permission
        @file_write_permissions << FileWritePermission.new
      end

      def form_data
        file_write_permissions.map &:form_data
      end

      def delete(i)
        file_write_permissions.delete_at i
        save
      end

    end
  end
end
