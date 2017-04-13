class App
  class Blueprint
    class Port < SectionCollectionItem

      form_attributes :port, :external, :protocol

      def protocol_collection
        { "TCP": :tcp, "UDP": :udp, "TCP and USP": :tcp_and_udp }
      end

    end
  end
end
