class App
  class Blueprint
    class PersistentDirectories < Section

      attr_reader :persistent_directories

      def data_location
        [ :software, :persistent_directories ]
      end

      def load_data
        self.persistent_directories_attributes = persistent_directories_persisted_data
      end

      def persistent_directories_persisted_data
        persisted_data.map.with_index do |persistent_directory, i|
          { i.to_s => persistent_directory }
        end.inject(:merge) || {}
      end

      def persistent_directories_attributes=(params)
        @persistent_directories = params.map { |i, persistent_directory_params| PersistentDirectory.new persistent_directory_params }
      end

      def build_persistent_directory
        @persistent_directories << PersistentDirectory.new
      end

      def form_data
        persistent_directories.map &:form_data
      end

      def delete(i)
        persistent_directories.delete_at i
        save
      end

    end
  end
end
