class App
  class Blueprint
    class PersistentFiles < Section

      attr_reader :persistent_files

      def data_location
        [ :software, :persistent_files ]
      end

      def load_data
        self.persistent_files_attributes = persistent_files_persisted_data
      end

      def persistent_files_persisted_data
        persisted_data.map.with_index do |persistent_file, i|
          { i.to_s => persistent_file }
        end.inject(:merge) || {}
      end

      def persistent_files_attributes=(params)
        @persistent_files = params.map { |i, persistent_file_params| PersistentFile.new persistent_file_params }
      end

      def build_persistent_file
        @persistent_files << PersistentFile.new
      end

      def form_data
        persistent_files.map &:form_data
      end

      def delete(i)
        persistent_files.delete_at i
        save
      end

    end
  end
end
