class App
  class AppBlueprint
    class RakeTask < ::Blueprint::SectionCollectionItem

      form_attributes :action, :always_run

      def form_data
        {
          action: action,
          always_run: cast_as_boolean(always_run)
        }
      end

    end
  end
end
