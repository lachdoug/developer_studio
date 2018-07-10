class App
  class AppBlueprint
    class InstalledPackage < ::Blueprint::SectionCollectionItem

      form_attributes :name,
                      :download_type,
                      :source_url,
                      :destination,
                      :extraction_command,
                      :command_options,
                      :path_to_extracted

    end
  end
end
