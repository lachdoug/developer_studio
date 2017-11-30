class Service
  class ServiceBlueprint
    class SoftLink < ::Blueprint::SectionCollectionItem

      form_attributes :source,
                      :target,
                      :owner

      def form_data
        {
          source: source,
          target: target,
          owner: owner,
        }
      end

    end
  end
end
