class Service
  class ServiceBlueprint
    class IncludedFile < ::Blueprint::SectionCollectionItem

      form_attributes :source, :destination, :template, :owner, :group, :permissions

      def to_s
        source || 'New'
      end



    end
  end
end
