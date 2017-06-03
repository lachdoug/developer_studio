class Service
  class ServiceBlueprint
    class Port < ::Blueprint::SectionCollectionItem

      form_attributes :port, :external, :protocol

      def protocol_collection
        { "TCP": :tcp, "UDP": :udp, "TCP and UDP": :tcp_and_udp }
      end

    end
  end
end
