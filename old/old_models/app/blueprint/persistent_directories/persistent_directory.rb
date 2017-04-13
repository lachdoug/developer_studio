class App
  class Blueprint
    class PersistentDirectories
      class PersistentDirectory

        include ActiveModel::Model

        attr_accessor :path

        def form_data
          { path: path }
        end

      end
    end
  end
end
