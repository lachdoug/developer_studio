class Service
  class ServiceBlueprint
    class Configurator
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
