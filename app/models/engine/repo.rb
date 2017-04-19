class Engine
  class Repo

    require 'open3'

    def self.list(type_plural)
      Dir.glob("repos/#{type_plural}/*").map{ |file_path| file_path.split("/").last }.sort
    end

    def self.clone(url, type_plural)
      ssh_url = url.sub('https://', 'ssh://')
      stdout, stderr, status = Open3.capture3("env GIT_SSH_COMMAND=\"ssh -i /home/home_dir/.ssh/identity\" git -C repos/#{type_plural} clone '#{ssh_url}'")
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
      @blueprint ||= Blueprint.new(self)
    end

    def readme
      @readme ||= Readme.new(self)
    end

    def release_notes
      @release_notes ||= ReleaseNotes.new(self)
    end

    def license
      @license ||= License.new(self)
    end

    def path
      "repos/#{engine.class.to_s.underscore.pluralize}/#{engine.name}"
    end

    def precheck
      blueprint.precheck
      readme.precheck
      release_notes.precheck
      license.precheck
      git_precheck
    end

    def git_precheck
      make_initial_commit if git_is_bare
    end

    def git_is_bare
      stdout, stderr, status = Open3.capture3("git -C #{path} cat-file -t HEAD")
      status.exitstatus == 128
    end

    def remote_web_url
      @remote_web_url ||= remote_url.sub('ssh://', 'https://')
    end

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

    def status
      `git -C #{path} add . ; git -C #{path} status`.
      sub( "  (use \"git push\" to publish your local commits)\n", '' ).
      sub( "  (use \"git reset HEAD <file>...\" to unstage)\n", '' ).
      sub("\n\n", "\n")
    end

    def make_initial_commit
      `git -C #{path} add -A`
      `git -C #{path} commit -a -m 'Initial commit'`
      `git -C #{path} branch --unset-upstream`
    end

    def commit(message)
      stdout, stderr, status = Open3.capture3("git -C #{path} commit -a -m '#{message}'")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr.split('fatal: ')[1] }
      end
    end

    def push
      stdout, stderr, status = Open3.capture3("env GIT_SSH_COMMAND=\"ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/home_dir/.ssh/identity\" git -C #{path} push")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr.split('fatal: ')[1].sub(' Email support@github.com for help', '') }
      end
    end

    def delete
      FileUtils.rm_rf path
    end

    # def update_license(message, author)
    #   current_commit = "#{author} - #{message}"
    #   license.tap do |cl|
    #     cl.license = current_commit + "\n\n" + cl.license
    #     cl.save
    #   end
    # end

  end
end
