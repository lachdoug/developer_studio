class App
  class Blueprint
    class TemplateFiles < Section

      attr_reader :template_files

      def data_location
        [ :software, :template_files ]
      end

      def load_data
        self.template_files_attributes = template_files_persisted_data
      end

      def template_files_persisted_data
        persisted_data.map.with_index do |template_file, i|
          { i.to_s => template_file }
        end.inject(:merge) || {}
      end

      def template_files_attributes=(params)
        @template_files = params.map { |id, template_file_params| TemplateFile.new template_file_params }
      end

      def build_template_file
        @template_files << TemplateFile.new
      end

      def form_data
        template_files.map(&:form_data)
      end

      def delete(i)
        template_files.delete_at i
        save
      end

    end
  end
end
