class App
  class AppBlueprint
    class Actionator
      class Chain

        include ActiveModel::Model

        attr_accessor :parameters, :target, :submit

        def form_data
          {
            parameters: parameters,
            target: target,
            submit: submit,
          }
        end

      end
    end
  end
end
