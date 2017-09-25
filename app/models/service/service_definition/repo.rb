class Service
  class ServiceDefinition
    class Repo

      attr_reader :service_definition, :error_message

      def initialize(service_definition)
        @service_definition = service_definition
      end

      def path
        @path ||= "#{Rails.application.config.persistent_data_directory}/repos/service_definitions_working_dir/#{service_definition.publisher_namespace}"
      end

      def file_path
        "#{service_definition.type_path}/#{service_definition.type_path.split('/').last}.yaml"
      end

      def exists?
        File.directory? path
      end

      def remote_has_current_branch?
        `git -C #{path} branch -r --contains current` != ''
      end

      def remote_url
        `git -C #{path} remote get-url origin`
      end

      def clone_remote
        stdout, stderr, status = Open3.capture3("git -C #{Rails.application.config.persistent_data_directory}/repos/service_definitions_working_dir clone '#{service_definition.settings_remote_url}'")
        if status.exitstatus == 0
          `git -C #{path} checkout -B current`
          true
        else
          @error_message = stderr.split('fatal: ')[1]
          false
        end
      end

      def log
        `git -C #{path} log`
      end

      def uncommitted_diffs
        @uncommitted_diffs ||= `git -C #{path} diff HEAD`
      end

      def committed_diffs
        if remote_has_current_branch?
          @committed_diffs ||= `git -C #{path} diff origin/current..HEAD`
        else
          @committed_diffs ||= `git -C #{path} diff origin/master..HEAD`
        end
      end

      def status
        `git -C #{path} status`.
        sub( "  (use \"git push\" to publish your local commits)\n", '' ).
        sub( "  (use \"git reset HEAD <file>...\" to unstage)\n", '' ).
        sub("\n\n", "\n").sub("\n\n", "\n") + ( committed_diffs.present? ?
                  "There are unpushed commits": "No unpushed commits")
      end

      def file_content
        # byebug
        File.read "#{path}/#{file_path}"
      rescue
        ''
      end

      def update
        byebug
        FileUtils.mkdir_p("#{path}/#{service_definition.type_path}") unless File.directory? "#{path}/#{service_definition.type_path}"
        File.write "#{path}/#{file_path}", service_definition.yaml_from_blueprint
        `git -C #{path} add -A`
      end

      def do_commit(message)
        # byebug
        stdout, stderr, status = Open3.capture3("git -C #{path} commit -m '#{message}'")
        # byebug
        if status.exitstatus == 0
          { success: true }
        else
          { success: false, message: stderr }
        end
      end

      def do_push
        # byebug
        stdout, stderr, status = Open3.capture3("git -C #{path} push -f origin current")
        if status.exitstatus == 0
          { success: true }
        else
          { success: false, message: stderr }
        end
      end

    end
  end
end
