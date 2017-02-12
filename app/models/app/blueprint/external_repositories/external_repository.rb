class App
  class Blueprint
    class ExternalRepositories
      class ExternalRepository

        include ActiveModel::Model

        attr_accessor :url, :key

        def form_data
          { url: url,
            key: key }
        end

      end
    end
  end
end
