class Service
  class ServiceBlueprint
    class LibraryScript < ::Blueprint::SectionCollectionItem

      form_attributes :name,
                      :language,
                      :content,
                      :sudo

      def to_s
        name || 'New'
      end

    end
  end
end
