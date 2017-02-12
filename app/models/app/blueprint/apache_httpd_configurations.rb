class App
  class Blueprint
    class ApacheHttpdConfigurations < Section

      attr_reader :apache_httpd_configurations

      def data_location
        [ :software, :apache_httpd_configurations ]
      end

      def load_data
        self.apache_httpd_configurations_attributes = apache_httpd_configurations_persisted_data
      end

      def apache_httpd_configurations_persisted_data
        persisted_data.map.with_index do |apache_httpd_configuration, i|
          { i.to_s => apache_httpd_configuration }
        end.inject(:merge) || {}
      end

      def apache_httpd_configurations_attributes=(params)
        @apache_httpd_configurations = params.map { |id, apache_httpd_configuration_params| ApacheHttpdConfiguration.new apache_httpd_configuration_params }
      end

      def build_apache_httpd_configuration
        @apache_httpd_configurations << ApacheHttpdConfiguration.new
      end

      def form_data
        apache_httpd_configurations.map(&:form_data)
      end

      def delete(i)
        apache_httpd_configurations.delete_at i
        save
      end

    end
  end
end
