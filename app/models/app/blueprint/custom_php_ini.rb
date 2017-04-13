class App
  class Blueprint
    class CustomPhpIni < SectionCollectionItem

      form_attributes :content

      def to_s
        content.present? ? content.split("\r\n").first : 'New'
      end

    end
  end
end
