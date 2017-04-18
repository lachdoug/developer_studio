class App
  class Blueprint
    class RakeTask < ::Blueprint::SectionCollectionItem

      form_attributes :action, :always_run

      def form_data
        { action: action,
          always_run: ActiveRecord::Type::Boolean.new.cast(always_run) }
      end

    end
  end
end
