class App
  class Blueprint
    class ApacheHtaccessFile < ::Blueprint::SectionCollectionItem

      form_attributes :directory, :content

      def to_s
        content.present? ? content.split("\r\n").first : 'New'
      end

    end
  end
end
