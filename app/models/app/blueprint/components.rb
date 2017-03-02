class App
  class Blueprint
    class Components < Section

      attr_accessor :path, :extract
      attr_reader :sources

      def data_location
        [ :software, :components ]
      end

      def load_data
        @path = persisted_data.dig :path
        @extract = persisted_data.dig :extract
        self.sources_attributes = sources_persisted_data
      end

      def sources_persisted_data
        persisted_data.dig( :sources ).map.with_index do |source, i|
          { i.to_s =>
            source.map do |k,v|
              if k.to_sym == :install_script
                { install_script_attributes: v }
              else
                { k => v }
              end
            end.inject(:merge) }
        end.inject(:merge) || {}
      end

      def sources_attributes=(params)
        @sources = params.map { |id, source_params| Source.new source_params }
      end

      def build_source
        @sources << Source.new.tap { |source| source.install_script_attributes = {} }
      end

      def form_data
        byebug
        {
          path: path,
          extract: extract == "1",
          sources: sources.map(&:form_data)
        }
      end

      def delete_source(i)
        sources.delete_at i
        save
      end

    end
  end
end
