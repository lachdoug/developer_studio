class App
  class Blueprint
    class DatabaseSeed < ::Blueprint::Section


      form_attributes :language, :content, :script

      def language
        @language || :text
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
