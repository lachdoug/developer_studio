class App
  class AppBlueprint
    class ApacheHttpdConfigurations < ::Blueprint::SectionCollection

      def data_location
        [ :software, :framework_specific, :apache_httpd_configurations ]
      end

    end
  end
end
