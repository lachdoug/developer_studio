class Engine
  class Repo
    class ReleaseNotes

      attr_reader :repo
      attr_writer :content

      def initialize(repo)
        @repo = repo
      end

      def content
        @content ||= repository_release_notes
      end

      def update(new_content)
        @content = new_content
        save
      end

      def precheck
        unless File.exist? "#{repo.path}/release_notes.md"
          File.write "#{repo.path}/release_notes.md", ''
        end
      end

      def repository_release_notes
        File.read "#{repo.path}/release_notes.md"
      rescue Errno::ENOENT # no file error
        ''
      end

      def save
        File.write "#{repo.path}/release_notes.md", content
      end

    end
  end
end
