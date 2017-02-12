class App
  class Blueprint
    class ReplacementStrings
      class ReplacementString

        include ActiveModel::Model

        attr_accessor :string, :source_file, :destination_file

        def form_data
          {
            string: string,
            source_file: source_file,
            destination_file: destination_file
          }
        end

      end
    end
  end
end
