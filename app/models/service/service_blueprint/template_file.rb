class Service
  class ServiceBlueprint
    class TemplateFile < ::Blueprint::SectionCollectionItem

      form_attributes :path, :content, :language, :user, :group, :permissions

      # def language
      #   @language ||= :text
      # end

      def to_s
        path || 'New'
      end

    end
  end
end
