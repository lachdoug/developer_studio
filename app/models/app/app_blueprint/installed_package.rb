class App
  class AppBlueprint
    class InstalledPackage < ::Blueprint::SectionCollectionItem

      form_attributes :name,
                      :source_url,
                      :destination,
                      :extraction_command,
                      :path_to_extracted

    end
  end
end
