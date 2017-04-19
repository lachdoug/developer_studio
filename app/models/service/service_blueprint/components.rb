class Service
  class ServiceBlueprint
    class Components < ::Blueprint::Section

      attr_accessor :path, :extract
      attr_reader :sources

      def update(params)
        assign_attributes(params)
        save
      end

      def build_section
        @path = data.dig :path
        @extract = data.dig :extract
        self.sources_attributes = sources_collection_data
      end

      def sources_collection_data
        data.dig( :sources ).map.with_index do |source, i|
          { i =>
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
        @sources = Sources.new self, params
      end

      def form_data
        {
          path: path,
          extract: ActiveRecord::Type::Boolean.new.cast(extract),
          sources: sources.form_data
        }
      end

    end
  end
end
