class Service
  class ServiceBlueprint
    class CustomPhpIni < ::Blueprint::SectionCollectionItem

      form_attributes :content

      def to_s
        content.present? ? content.split("\r\n").first : 'New'
      end

    end
  end
end