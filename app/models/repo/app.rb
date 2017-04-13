module Repo
  class App

    require 'open3'

    def self.list
      Dir.glob('repos/apps/*').map{ |file_path| file_path.split("/").last }.sort
    end

    def self.clone(url)
      ssh_url = url.sub('https://', 'ssh://')
      stdout, stderr, status = Open3.capture3("env GIT_SSH_COMMAND=\"ssh -i /home/home_dir/.ssh/identity\" git -C repos/apps clone '#{ssh_url}'")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr.split('fatal: ')[1] }
      end
    end

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def precheck
      blueprint.precheck
      readme.precheck
      release_notes.precheck
      license.precheck
    end

    def remote_web_url
      @remote_web_url ||= remote_url.sub('ssh://', 'https://')
    end

    def remote_url
      `git -C repos/apps/#{name} remote get-url origin`
    end

    def log
      `git -C repos/apps/#{name} log`
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

    def uncommitted_diffs
      @uncommitted_diffs ||= `git -C repos/apps/#{name} diff HEAD`
    end

    def committed_diffs
      @committed_diffs ||= `git -C repos/apps/#{name} diff origin/master..HEAD`
    end

    def commit(message)
      stdout, stderr, status = Open3.capture3("git -C repos/apps/#{name} commit -a -m '#{message}'")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr.split('fatal: ')[1] }
      end
    end

    def status
      `git -C repos/apps/#{name} add . ; git -C repos/apps/#{name} status`.
      sub( "  (use \"git push\" to publish your local commits)\n", '' ).
      sub( "  (use \"git reset HEAD <file>...\" to unstage)\n", '' ).
      sub("\n\n", "\n")
    end

    def push
      stdout, stderr, status = Open3.capture3("env GIT_SSH_COMMAND=\"ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/home_dir/.ssh/identity\" git -C repos/apps/#{name} push")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr.split('fatal: ')[1].sub(' Email support@github.com for help', '') }
      end
    end

    def update_license(message, author)
      current_commit = "#{author} - #{message}"
      license.tap do |cl|
        cl.license = current_commit + "\n\n" + cl.license
        cl.save
      end
    end

  end
end
