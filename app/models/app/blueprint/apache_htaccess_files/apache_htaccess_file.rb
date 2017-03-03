class App
  class Blueprint
    class ApacheHtaccessFiles
      class ApacheHtaccessFile

        include ActiveModel::Model

        attr_accessor :directory, :content

        def form_data
          {
            directory: directory,
            content: content
          }
        end

      end
    end
  end
end
