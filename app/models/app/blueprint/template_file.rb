class App
  class Blueprint
    class TemplateFile < SectionCollectionItem

      form_attributes :path, :content, :language

      def language
        @language ||= :text
      end

      def to_s
        path || 'New'
      end

    end
  end
end
