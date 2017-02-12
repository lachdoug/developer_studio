class App
  class Blueprint
    class InstalledPackages
      class InstalledPackage

        include ActiveModel::Model

        attr_accessor :name,
                      :source_url,
                      :destination,
                      :extraction_command,
                      :path_to_extracted

        def form_data
          {
            name: name,
            source_url: source_url,
            destination: destination,
            extraction_command: extraction_command,
            path_to_extracted: path_to_extracted
          }
        end

      end
    end
  end
end
