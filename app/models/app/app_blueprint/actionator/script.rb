class App
  class AppBlueprint
    class Actionator
      class Script

        include ActiveModel::Model

        attr_accessor :language, :content

        def form_data
          {
            language: language,
            content: content
          }
        end

      end
    end
  end
end
