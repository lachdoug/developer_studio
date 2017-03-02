class App
  class Blueprint
    class SystemPackages
      class SystemPackage

        include ActiveModel::Model

        attr_accessor :package, :version

        def form_data
          { package: package,
            version: version }
        end

      end
    end
  end
end
