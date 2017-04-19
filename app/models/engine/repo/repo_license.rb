class Engine
  class Repo
    class RepoLicense

      attr_reader :repo
      attr_writer :license

      def initialize(repo)
        @repo = repo
      end

      def license
        @license ||= repository_license
      end

      def update(new_content)
        @license = new_content
        save
      end

      def precheck
        unless File.exist? "#{repo.path}/LICENSE"
          File.write "#{repo.path}/LICENSE", ''
        end
      end

      def repository_license
        File.read "#{repo.path}/LICENSE"
      end

      def save
        File.write "#{repo.path}/LICENSE", license
      end

    end
  end
end
