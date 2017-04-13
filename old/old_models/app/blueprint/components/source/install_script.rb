class App
  class Blueprint
    class Components
      class Source
        class InstallScript

          include ActiveModel::Model

          attr_accessor :language, :content

          def form_data
            {
              language: language,
              content: content
            }
          end

        end
      end
    end
  end
end
