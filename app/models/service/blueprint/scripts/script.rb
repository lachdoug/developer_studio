class Service
  class Blueprint
    class Scripts
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
