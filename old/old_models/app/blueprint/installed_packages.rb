class App
  class Blueprint
    class InstalledPackages < Section

      attr_reader :installed_packages

      def all
        @collection
      end

      def each_with_index
        @collection.each.with_index { |item, i| yield item, i }
      end

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
        @collection = params.map { |i, installed_package_params| InstalledPackage.new installed_package_params }
      end

      def build_installed_package
        @collection << InstalledPackage.new
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
