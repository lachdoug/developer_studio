class Service
  class ServiceBlueprint
    class Components
      class Sources < ::Blueprint::SectionNestedCollection

        def build
          super.tap &:build_install_script
        end

      end
    end
  end
end
