class Engine
  class Repo
    class Readme

      attr_reader :repo
      attr_writer :content

      def initialize(repo)
        @repo = repo
      end

      def content
        @content ||= repository_readme
      end

      def update(new_content)
        @content = new_content
        save
      end

      def repository_readme
        File.read "#{repo.path}/README.md"
      end

      def precheck
        check_for_misnamed_readme
        unless File.exist? "#{repo.path}/README.md"
          File.write "#{repo.path}/README.md", ''
        end
      end

      def check_for_misnamed_readme
        if File.exist? "#{repo.path}/readme.md"
          File.rename "#{repo.path}/readme.md", "#{repo.path}/README.md"
        elsif File.exist? "#{repo.path}/readme.txt"
          File.rename "#{repo.path}/readme.txt", "#{repo.path}/README.md"
        elsif File.exist? "#{repo.path}/README.txt"
          File.rename "#{repo.path}/README.txt", "#{repo.path}/README.md"
        elsif File.exist? "#{repo.path}/readme.txt"
          File.rename "#{repo.path}/readme.txt", "#{repo.path}/README.md"
        end
      end

      def save
        File.write "#{repo.path}/README.md", content
      end

    end
  end
end
