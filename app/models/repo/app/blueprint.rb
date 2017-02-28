module Repo
  class App
    class Blueprint

      attr_reader :app
      attr_writer :content

      def initialize(app)
        @app = app
      end

      def content
        @content ||= blueprint_json
      end

      def precheck
        unless File.exist? "repos/apps/#{app.name}/blueprint.json"
          File.write "repos/apps/#{app.name}/blueprint.json", ''
        end
      end

      def blueprint_json
        Conform::AppBlueprint.new(repository_blueprint_json).Schema_1_0
      end

      def repository_blueprint_json
        JSON.parse(repository_blueprint_file_content).deep_symbolize_keys
      rescue
        {}
      end

      def repository_blueprint_file_content
        File.read "repos/apps/#{app.name}/blueprint.json"
      end

      def save
        File.write "repos/apps/#{app.name}/blueprint.json", ( JSON.pretty_generate(content) + "\n" )
      end

      def update(new_content)
        @content = new_content
        save
      end

    end
  end
end
