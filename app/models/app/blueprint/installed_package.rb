class App
  class Blueprint
    class InstalledPackage < SectionCollectionItem

      form_attributes :name,
                      :source_url,
                      :destination,
                      :extraction_command,
                      :path_to_extracted

    end
  end
end
