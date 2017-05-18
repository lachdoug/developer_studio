class App
  class AppBlueprint
    class RakeTasks < ::Blueprint::SectionCollection

      def data_location
        [ :software, :framework_specific, :rake_tasks ]
      end

    end
  end
end
