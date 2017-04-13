class App
  class Blueprint
    class ReplacementString < SectionCollectionItem

      form_attributes :string, :source_file, :destination_file

      def to_s
        string || 'New'
      end

    end
  end
end
