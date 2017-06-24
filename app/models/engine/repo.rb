class Engine
  class Repo

    require 'open3'

    def self.list(type_plural)
      Dir.glob("#{Rails.application.config.persistent_data_directory}/repos/#{type_plural}/*").map{ |file_path| file_path.split("/").last }.sort
    end

    def self.clone(url, type_plural)
      ssh_url = url.sub('https://', 'ssh://')
      stdout, stderr, status = Open3.capture3("env GIT_SSH_COMMAND=\"ssh -i /home/home_dir/.ssh/identity\" git -C #{Rails.application.config.persistent_data_directory}/repos/#{type_plural} clone '#{ssh_url}'")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr.split('fatal: ')[1] }
      end
    end

    attr_reader :engine

    def initialize(engine)
      @engine = engine
    end

    def blueprint
      @blueprint ||= RepoBlueprint.new(self)
    end

    def readme
      @readme ||= RepoReadme.new(self)
    end

    def release_notes
      @release_notes ||= RepoReleaseNotes.new(self)
    end

    def license
      @license ||= RepoLicense.new(self)
    end

    def path
      "#{Rails.application.config.persistent_data_directory}/repos/#{engine.class.to_s.underscore.pluralize}/#{engine.name}"
    end

    def precheck
      blueprint.precheck
      readme.precheck
      release_notes.precheck
      license.precheck
      git_precheck
    end

    def git_precheck
      do_initial_commit_and_push if git_is_bare
    end

    def git_is_bare
      stdout, stderr, status = Open3.capture3("git -C #{path} cat-file -t HEAD")
      status.exitstatus == 128
    end

    # def remote_web_url
    #   @remote_web_url ||= remote_url.sub('ssh://', 'https://')
    # end

    def uncommitted_diffs
      @uncommitted_diffs ||= `git -C #{path} diff HEAD`
    end

    def committed_diffs
      @committed_diffs ||= `git -C #{path} diff origin/master..HEAD`
    end

    def remote_url
      `git -C #{path} remote get-url origin`
    end

    def log
      `git -C #{path} log`
    end

    def last_commit_message
      `git -C #{path} log -1`.split("\n")[4..-1].map{|line| line[1..-1]}.join("\n")
    end

    def status
      `git -C #{path} add . ; git -C #{path} status`.
      sub( "  (use \"git push\" to publish your local commits)\n", '' ).
      sub( "  (use \"git reset HEAD <file>...\" to unstage)\n", '' ).
      sub("\n\n", "\n").sub("\n\n", "\n") + ( committed_diffs.present? ?
                "There are unpushed commits": "No unpushed commits")
    end

    def do_initial_commit_and_push
      add_files_to_repo
      commit 'Initial commit'
      set_remote_branch
      push
    end

    def add_files_to_repo
      `git -C #{path} add -A`
    end

    def set_remote_branch
      `git -C #{path} branch --unset-upstream`
      `git -C #{path} branch --set-upstream-to origin/master`
    end

    def commit(message)
      stdout, stderr, status = Open3.capture3("git -C #{path} commit -m '#{message}'")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr }
      end
    end

    def push
      stdout, stderr, status = Open3.capture3("git -C #{path} push -f origin master")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr }
      end
    end

    def delete
      FileUtils.rm_rf path
    end

  end
end
