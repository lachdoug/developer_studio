class App
  class Blueprint
    class SystemPackages
      class SystemPackage

        include ActiveModel::Model

        attr_accessor :package

        def form_data
          { package: package }
        end

      end
    end
  end
end
