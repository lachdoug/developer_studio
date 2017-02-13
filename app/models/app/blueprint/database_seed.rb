class App
  class Blueprint
    class DatabaseSeed < Section

      attr_accessor :language, :content, :script

      def data_location
        [ :software, :database_seed ]
      end

      def load_data
        @language = persisted_data.dig :language
        @content = persisted_data.dig :content
        @script = persisted_data.dig :script
      end

      def form_data
        {
          language: language,
          content: content,
          script: ActiveRecord::Type::Boolean.new.cast(script)
        }
      end

      def database_seed_language_collection
        dropdowns_config[:database_seed_languages]
      end

    end
  end
end
