class Service
  class Blueprint
    class TemplateFile < ::Blueprint::SectionCollectionItem

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
