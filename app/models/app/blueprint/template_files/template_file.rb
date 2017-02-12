class App
  class Blueprint
    class TemplateFiles
      class TemplateFile

        include ActiveModel::Model

        attr_accessor :name, :path, :language, :content

        def form_data
          {
            name: name,
            path: path,
            language: language,
            content: content
          }
        end

      end
    end
  end
end
