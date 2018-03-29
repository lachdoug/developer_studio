class Service
  class ServiceBlueprint
    class CustomFile < ::Blueprint::SectionCollectionItem

      form_attributes :path, :content, :language, :type, :execute, :sudo

      def to_s
        [type, path].compact.join(' ') || 'New'
      end

      def types
        [ "actionator",
          "backup",
          "configurator",
          "first_run",
          "service",
          "startup",
          "signal" ]
      end

    end
  end
end
