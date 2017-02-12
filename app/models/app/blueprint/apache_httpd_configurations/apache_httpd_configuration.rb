class App
  class Blueprint
    class ApacheHttpdConfigurations
      class ApacheHttpdConfiguration

        include ActiveModel::Model

        attr_accessor :content

        def form_data
          {
            content: content
          }
        end

      end
    end
  end
end
