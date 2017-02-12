module Repository
  class Repository

    require 'rugged'
    require 'fileutils'

    def initialize
      @local_repository_path = ENV["GITDIR"] || development_repository
      @service_definitions_source_url = ENV["SERVICE_DEFINITON_REPOSITORY_URL"] || 'https://github.com/EnginesOS/ServiceDefinitions.git'
    end

    def list_service_definition_paths
      service_definitions_file_list.map { |filepath| filepath.sub(service_definitions_directory + '/providers/', '').split('/')[0..-2].join('/') }.sort
    end

    def all_service_definition_attributes
      list_service_definition_paths.map do |service_definition_path|
        ::Repository::ServiceDefinition::Load.new(service_definition_path).attributes
      end
    end

    def reset_service_definitions
      clear_local_service_definitions && clone_service_definitions
    end

    def service_definition_for(service_definition_path)
      filepath = filepath_for(service_definition_path)
      yaml = YAML::load File.read(filepath).gsub('!ruby/object:SoftwareServiceDefinition', '') if File.exist? filepath
      yaml.deep_symbolize_keys if yaml.is_a? Hash
    end

    def service_definition_readme_for(service_definition_path)
      filepath = readme_filepath_for(service_definition_path)

p :filepath
p filepath
p File.exist? filepath

      File.read filepath if File.exist? filepath
    end

    def save_service_definition(service_definition_path, service_definition_yaml, readme=nil, name=nil, email=nil, message=nil)
      name = 'no_username' if name.empty?
      email = 'no_email' if email.empty?
      message = 'no_message' if message.empty?
      git_path = @local_repository_path + '/service_definitions/'
      path = git_path + 'providers/' + service_definition_path
      filename = service_definition_path.split('/').last + '.yaml'
      filepath = path + '/' + filename
      readme_filepath = path + '/readme.md'
      repo = git_repository git_path
      FileUtils.mkdir_p(path)
      File.write( filepath, service_definition_yaml)
      File.write( readme_filepath, readme) if readme.present?
      index = repo.index
      repo.index.add_all()
      options = {}
      options[:tree] = index.write_tree(repo)
      options[:author] = { :email => email, :name => name, :time => Time.now }
      options[:committer] = { :email => email, :name => name, :time => Time.now }
      options[:message] ||= message
      options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
      options[:update_ref] = 'HEAD'
      Rugged::Commit.create(repo, options)
    # rescue
    #   false
    end

    def save_blueprint_version(blueprint_path, blueprint_json, readme=nil, name=nil, email=nil, message=nil)
      name = 'no_username' if name.empty?
      email = 'no_email' if email.empty?
      message = 'no_message' if message.empty?
      path = @local_repository_path + '/blueprints/' + blueprint_path
      blueprint_filepath = path + '/blueprint.json'
      readme_filepath = path + '/readme.md'
      FileUtils.mkdir_p(path)
      repo = git_repository path
      File.write( blueprint_filepath, blueprint_json)
      File.write( readme_filepath, readme) if readme.present?
      index = repo.index
      repo.index.add_all()
      options = {}
      options[:tree] = index.write_tree(repo)
      options[:author] = { :email => email, :name => name, :time => Time.now }
      options[:committer] = { :email => email, :name => name, :time => Time.now }
      options[:message] ||= message
      options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
      options[:update_ref] = 'HEAD'
      Rugged::Commit.create(repo, options)
    # rescue
    #   false
    end

    def git_repository(path)
      Rugged::Repository.new(path)
    rescue
      Rugged::Repository.init_at(path)
    end

# p :is_a_git_repo
# p repo
#
#     end

    private

    def filepath_for(service_definition_path)
      service_definitions_directory + '/providers/' + service_definition_path + '/' + service_definition_path.split('/').last + '.yaml'
    end

    def readme_filepath_for(service_definition_path)
      service_definitions_directory + '/providers/' + service_definition_path + '/readme.md'
    end

    def clear_local_service_definitions
      FileUtils.rm_rf(@local_repository_path)
    end

    def clone_service_definitions
      Rugged::Repository.clone_at @service_definitions_source_url, service_definitions_directory
    end

    # def local_repository
    #   Rugged::Repository.new @local_repository_path
    # end

    def development_repository
      "/tmp/engines/git".tap { |path| ensure_directory_exists path }
    end

    def ensure_directory_exists(path)
      FileUtils.mkdir_p path unless File.directory? path
    end

    def service_definitions_directory
      @service_definitions_directory ||= @local_repository_path + '/service_definitions'
    end

    def service_definitions_file_list
      @service_definitions_file_list ||=
        Dir.glob(service_definitions_directory + '/**/*.yaml')
    end

  end
end
