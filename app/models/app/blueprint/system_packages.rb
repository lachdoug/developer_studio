class App
  class Blueprint
    class SystemPackages < Section

      attr_reader :system_packages

      def data_location
        [ :software, :system_packages ]
      end

      def load_data
        self.system_packages_attributes = system_packages_persisted_data
      end

      def system_packages_persisted_data
        persisted_data.map.with_index do |system_package, i|
          { i.to_s => system_package }
        end.inject(:merge) || {}
      end

      def system_packages_attributes=(params)
        @system_packages = params.map { |i, system_package_params| SystemPackage.new system_package_params }
      end

      def build_system_package
        @system_packages << SystemPackage.new
      end

      def form_data
        system_packages.map &:form_data
      end

      def delete(i)
        system_packages.delete_at i
        save
      end

    end
  end
end
