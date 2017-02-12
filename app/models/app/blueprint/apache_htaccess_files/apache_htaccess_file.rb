class App
  class Blueprint
    class ApacheHtaccessFiles
      class ApacheHtaccessFile

        include ActiveModel::Model

        attr_accessor :path, :content

        def form_data
          {
            path: path,
            content: content
          }
        end

      end
    end
  end
end
