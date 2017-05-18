class App
  class AppBlueprint
    class ApacheHtaccessFiles < ::Blueprint::SectionCollection

      def data_location
        [ :software, :framework_specific, :apache_htaccess_files ]
      end

    end
  end
end
