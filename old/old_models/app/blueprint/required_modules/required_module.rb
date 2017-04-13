class App
  class Blueprint
    class RequiredModules
      class RequiredModule

        include ActiveModel::Model

        attr_accessor :type, :os_package, :name

        def form_data
          {
            name: name,
            type: type,
            os_package: os_package
          }
        end

      end
    end
  end
end
