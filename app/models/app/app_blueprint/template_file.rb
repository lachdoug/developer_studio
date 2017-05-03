class App
  class AppBlueprint
    class TemplateFile < ::Blueprint::SectionCollectionItem

      form_attributes :path, :content, :language

      def language
        @language ||= :text
      end

      def to_s
        path || 'New'
      end

      def template_file_languages
        dropdowns_config[:template_file_languages]
      end

    end
  end
end
