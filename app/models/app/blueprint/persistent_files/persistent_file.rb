class App
  class Blueprint
    class PersistentFiles
      class PersistentFile

        include ActiveModel::Model

        attr_accessor :path

        def form_data
          { path: path }
        end

      end
    end
  end
end
