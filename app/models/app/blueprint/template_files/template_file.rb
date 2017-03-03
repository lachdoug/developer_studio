class App
  class Blueprint
    class TemplateFiles
      class TemplateFile

        include ActiveModel::Model

        attr_accessor :path, :content
        attr_writer :language

        def language
          @language || :text
        end

        def form_data
          {
            path: path,
            language: language,
            content: content
          }
        end

      end
    end
  end
end
