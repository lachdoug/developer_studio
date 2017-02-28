module Repo
  class App
    class ReleaseNotes

      attr_reader :app
      attr_writer :content

      def initialize(app)
        @app = app
      end

      def content
        @content ||= repository_release_notes
      end

      def update(new_content)
        @content = new_content
        save
      end

      def precheck
        unless File.exist? "repos/apps/#{app.name}/release_notes.md"
          File.write "repos/apps/#{app.name}/release_notes.md", ''
        end
      end

      def repository_release_notes
        File.read "repos/apps/#{app.name}/release_notes.md"
      rescue Errno::ENOENT # no file error
        ''
      end

      def save
        File.write "repos/apps/#{app.name}/release_notes.md", content
      end

    end
  end
end
