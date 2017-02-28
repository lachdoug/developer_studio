module Repo
  class App
    class Readme

      attr_reader :app
      attr_writer :content

      def initialize(app)
        @app = app
      end

      def content
        @content ||= repository_readme
      end

      def update(new_content)
        @content = new_content
        save
      end

      def repository_readme
        File.read "repos/apps/#{app.name}/README.md"
      end

      def precheck
        check_for_misnamed_readme
        unless File.exist? "repos/apps/#{app.name}/README.md"
          File.write "repos/apps/#{app.name}/README.md", ''
        end
      end

      def check_for_misnamed_readme
        if File.exist? "repos/apps/#{app.name}/readme.md"
          File.rename "repos/apps/#{app.name}/readme.md", "repos/apps/#{app.name}/README.md"
        elsif File.exist? "repos/apps/#{app.name}/readme.txt"
          File.rename "repos/apps/#{app.name}/readme.txt", "repos/apps/#{app.name}/README.md"
        elsif File.exist? "repos/apps/#{app.name}/README.txt"
          File.rename "repos/apps/#{app.name}/README.txt", "repos/apps/#{app.name}/README.md"
        elsif File.exist? "repos/apps/#{app.name}/readme.txt"
          File.rename "repos/apps/#{app.name}/readme.txt", "repos/apps/#{app.name}/README.md"
        end
      end

      def save
        File.write "repos/apps/#{app.name}/README.md", content
      end

    end
  end
end
