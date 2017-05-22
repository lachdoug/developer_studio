class Engine
  class Repo
    class RepoBlueprint

      attr_reader :repo
      attr_writer :content

      def initialize(repo)
        @repo = repo
      end

      def content
        @content ||= repository_blueprint_json
      end

      def conform_content
        @content = blueprint_conform_class.new(content).Schema_1_0
      end

      def timestamp_content
        content.tap do |c|
          c[:metadata][:timestamp] = Time.now.utc
        end
      end

      def precheck
        unless File.exist? "#{repo.path}/blueprint.json"
          File.write "#{repo.path}/blueprint.json", ''
        end
        conform_content
        save
      end

      def blueprint_conform_class
        "Conform::#{repo.engine.class}Blueprint".constantize
      end

      def repository_blueprint_json
        JSON.parse(repository_blueprint_file_content).deep_symbolize_keys
      rescue
        {}
      end

      def repository_blueprint_file_content
        File.read "#{repo.path}/blueprint.json"
      end

      def save
        File.write "#{repo.path}/blueprint.json", ( JSON.pretty_generate(content) + "\n" )
      end

      def update(new_content)
        @content = new_content
        conform_content
        timestamp_content
        save
        return @content
      end

    end
  end
end
