class Service
  class Blueprint
    class ApacheHttpdConfiguration < ::Blueprint::SectionCollectionItem

      form_attributes :content

      def to_s
        content.present? ? content.split("\r\n").first : 'New'
      end

    end
  end
end
