class App
  class Blueprint
    class Actionator
      class Variables < ::Blueprint::SectionNestedCollection

        def build
          super.tap &:build_input
        end

      end
    end
  end
end
