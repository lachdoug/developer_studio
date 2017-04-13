class App
  class Blueprint
    class Ports
      class Port

        include ActiveModel::Model

        attr_accessor :port, :external, :protocol

        def form_data
          {
            port: port,
            external: external,
            protocol: protocol
          }
        end

        def protocol_collection
          [:tcp, :udp, :tcp_and_udp]
        end

      end
    end
  end
end
