class App
  class Blueprint
    class Ports < Section

      attr_reader :ports

      def data_location
        [ :software, :ports ]
      end

      def load_data
        self.ports_attributes = ports_persisted_data
      end

      def ports_persisted_data
        persisted_data.map.with_index do |port, i|
          { i.to_s => port }
        end.inject(:merge) || {}
      end

      def ports_attributes=(params)
        @ports = params.map { |id, port_params| Port.new port_params }
      end

      def build_port
        @ports << Port.new
      end

      def form_data
        ports.map(&:form_data)
      end

      def delete(i)
        ports.delete_at i
        save
      end

    end
  end
end
