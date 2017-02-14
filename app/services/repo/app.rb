module Repo
  class App

    require 'open3'

    def self.list
      Dir.glob('repos/apps/*').map{ |file_path| file_path.split("/").last }.sort
    end

    def self.clone(url)
      stdout, stderr, status = Open3.capture3("git -C repos/apps clone '#{url}'")
      if status.exitstatus == 0
        ssh_url = url.sub('https://', 'ssh://')
        `git -C repos/apps remote origin set-url '#{ssh_url}'`
        { success: true }
      else
        { success: false, message: stderr.split('fatal: ')[1] }
      end
    end

    # def self.name_from_url(url)
    #   url.split('/').last.split('.').first
    # end

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def precheck
      blueprint.precheck
      readme.precheck
      release_notes.precheck
      license.precheck
      `git -C repos/apps/#{name} add -A`
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
      # byebug
      stdout, stderr, status = Open3.capture3("git -C repos/apps/#{name} push")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr.split('fatal: ')[1] }
      end
    end

    def update_license(message, author)
      current_commit = "#{author} - #{message}"
      license.tap do |cl|
        cl.license = current_commit + "\n\n" + cl.license
        cl.save
      end
    end

    # def commit_history
    #
    #   tab = []
    #   walker = Rugged::Walker.new(git_repo)
    #   walker.sorting(Rugged::SORT_DATE)
    #   unless git_repo.head_unborn?
    #     walker.push(git_repo.head.target)
    #   end
    #   walker.each do |commit|
    #     if commit.diff(paths: ["path_of_file"]).size > 0
    #        tab.push(commit)
    #     end
    #   end
    #   tab.join "\n"
    # end



    # def

# https://github.com/EnginesOS-Blueprints/RoundCube.git

  #
  #     def list_service_definition_paths
  #       service_definitions_file_list.map { |filepath| filepath.sub(service_definitions_directory + '/providers/', '').split('/')[0..-2].join('/') }.sort
  #     end
  #
  #     def all_service_definition_attributes
  #       list_service_definition_paths.map do |service_definition_path|
  #         ::Repository::ServiceDefinition::Load.new(service_definition_path).attributes
  #       end
  #     end
  #
  #     def reset_service_definitions
  #       clear_local_service_definitions && clone_service_definitions
  #     end
  #
  #     def service_definition_for(service_definition_path)
  #       filepath = filepath_for(service_definition_path)
  #       yaml = YAML::load File.read(filepath).gsub('!ruby/object:SoftwareServiceDefinition', '') if File.exist? filepath
  #       yaml.deep_symbolize_keys if yaml.is_a? Hash
  #     end
  #
  #     def service_definition_readme_for(service_definition_path)
  #       filepath = readme_filepath_for(service_definition_path)
  #
  # p :filepath
  # p filepath
  # p File.exist? filepath
  #
  #       File.read filepath if File.exist? filepath
  #     end
  #
  #     def save_service_definition(service_definition_path, service_definition_yaml, readme=nil, name=nil, email=nil, message=nil)
  #       name = 'no_username' if name.empty?
  #       email = 'no_email' if email.empty?
  #       message = 'no_message' if message.empty?
  #       git_path = @local_repository_path + '/service_definitions/'
  #       path = git_path + 'providers/' + service_definition_path
  #       filename = service_definition_path.split('/').last + '.yaml'
  #       filepath = path + '/' + filename
  #       readme_filepath = path + '/readme.md'
  #       repo = git_repository git_path
  #       FileUtils.mkdir_p(path)
  #       File.write( filepath, service_definition_yaml)
  #       File.write( readme_filepath, readme) if readme.present?
  #       index = repo.index
  #       repo.index.add_all()
  #       options = {}
  #       options[:tree] = index.write_tree(repo)
  #       options[:author] = { :email => email, :name => name, :time => Time.now }
  #       options[:committer] = { :email => email, :name => name, :time => Time.now }
  #       options[:message] ||= message
  #       options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
  #       options[:update_ref] = 'HEAD'
  #       Rugged::Commit.create(repo, options)
  #     # rescue
  #     #   false
  #     end
  #
  #     def save_blueprint_version(blueprint_path, blueprint_json, readme=nil, name=nil, email=nil, message=nil)
  #       name = 'no_username' if name.empty?
  #       email = 'no_email' if email.empty?
  #       message = 'no_message' if message.empty?
  #       path = @local_repository_path + '/blueprints/' + blueprint_path
  #       blueprint_filepath = path + '/blueprint.json'
  #       readme_filepath = path + '/readme.md'
  #       FileUtils.mkdir_p(path)
  #       repo = git_repository path
  #       File.write( blueprint_filepath, blueprint_json)
  #       File.write( readme_filepath, readme) if readme.present?
  #       index = repo.index
  #       repo.index.add_all()
  #       options = {}
  #       options[:tree] = index.write_tree(repo)
  #       options[:author] = { :email => email, :name => name, :time => Time.now }
  #       options[:committer] = { :email => email, :name => name, :time => Time.now }
  #       options[:message] ||= message
  #       options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
  #       options[:update_ref] = 'HEAD'
  #       Rugged::Commit.create(repo, options)
  #     # rescue
  #     #   false
  #     end
  #
  #     def git_repository(path)
  #       Rugged::Repository.new(path)
  #     rescue
  #       Rugged::Repository.init_at(path)
  #     end
  #
  # # p :is_a_git_repo
  # # p repo
  # #
  # #     end
  #
  #     private
  #
  #     def filepath_for(service_definition_path)
  #       service_definitions_directory + '/providers/' + service_definition_path + '/' + service_definition_path.split('/').last + '.yaml'
  #     end
  #
  #     def readme_filepath_for(service_definition_path)
  #       service_definitions_directory + '/providers/' + service_definition_path + '/readme.md'
  #     end
  #
  #     def clear_local_service_definitions
  #       FileUtils.rm_rf(@local_repository_path)
  #     end
  #
  #     def clone_service_definitions
  #       Rugged::Repository.clone_at @service_definitions_source_url, service_definitions_directory
  #     end
  #
  #     # def local_repository
  #     #   Rugged::Repository.new @local_repository_path
  #     # end
  #
  #     def development_repository
  #       "/tmp/engines/git".tap { |path| ensure_directory_exists path }
  #     end
  #
  #     def ensure_directory_exists(path)
  #       FileUtils.mkdir_p path unless File.directory? path
  #     end
  #
  #     def service_definitions_directory
  #       @service_definitions_directory ||= @local_repository_path + '/service_definitions'
  #     end
  #
  #     def service_definitions_file_list
  #       @service_definitions_file_list ||=
  #         Dir.glob(service_definitions_directory + '/**/*.yaml')
  #     end

  end
end
