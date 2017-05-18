class App
  class AppBlueprint
    class CustomPhpInis < ::Blueprint::SectionCollection

      def data_location
        [ :software, :framework_specific, :custom_php_inis ]
      end

    end
  end
end
