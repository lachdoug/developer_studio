class App
  class Blueprint
    class ApacheHtaccessFiles < Section

      attr_reader :apache_htaccess_files

      def data_location
        [ :software, :apache_htaccess_files ]
      end

      def load_data
        self.apache_htaccess_files_attributes = apache_htaccess_files_persisted_data
      end

      def apache_htaccess_files_persisted_data
        persisted_data.map.with_index do |apache_htaccess_file, i|
          { i.to_s => apache_htaccess_file }
        end.inject(:merge) || {}
      end

      def apache_htaccess_files_attributes=(params)
        @apache_htaccess_files = params.map { |id, apache_htaccess_file_params| ApacheHtaccessFile.new apache_htaccess_file_params }
      end

      def build_apache_htaccess_file
        @apache_htaccess_files << ApacheHtaccessFile.new
      end

      def form_data
        apache_htaccess_files.map(&:form_data)
      end

      def delete(i)
        apache_htaccess_files.delete_at i
        save
      end

    end
  end
end
