module Repo
  class App
    class License

      attr_reader :app
      attr_writer :license

      def initialize(app)
        @app = app
      end

      def license
        @license ||= repository_license
      end

      def update(new_content)
        @license = new_content
        save
      end

      def precheck
        unless File.exist? "repos/apps/#{app.name}/LICENSE"
          File.write "repos/apps/#{app.name}/LICENSE", ''
        end
      end

      def repository_license
        File.read "repos/apps/#{app.name}/LICENSE"
      end

      def save
        File.write "repos/apps/#{app.name}/LICENSE", license
      end

    end
  end
end
