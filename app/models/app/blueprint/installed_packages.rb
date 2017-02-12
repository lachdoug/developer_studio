class App
  class Blueprint
    class InstalledPackages < Section

      attr_reader :installed_packages

      def data_location
        [ :software, :installed_packages ]
      end

      def load_data
        self.installed_packages_attributes = installed_packages_persisted_data
      end

      def installed_packages_persisted_data
        persisted_data.map.with_index do |installed_package, i|
          { i.to_s => installed_package }
        end.inject(:merge) || {}
      end

      def installed_packages_attributes=(params)
        @installed_packages = params.map { |i, installed_package_params| InstalledPackage.new installed_package_params }
      end

      def build_installed_package
        @installed_packages << InstalledPackage.new
      end

      def form_data
        installed_packages.map &:form_data
      end

      def delete(i)
        installed_packages.delete_at i
        save
      end

    end
  end
end
