module Settings
  class ServiceDefinitionNamespace

    require 'fileutils'
    include ActiveModel::Model

    def self.path
      "#{Rails.application.config.persistent_data_directory}/repos/service_definitions"
    end

    def self.list
      Dir.glob("#{path}/*").map{ |file_path| file_path.split("/").last }.sort
    end

    def self.all
      list.map{ |name| new(name) }
    end

    def self.publisher_namespaces_collection
      list
    end

    def self.type_paths_collection_for(publisher_name)
      new(publisher_name).service_definitions.map &:type_path
    end

    def initialize(name)
      # byebug
      @name = name
    end

    attr_accessor :name
    attr_reader :error_message

    def path
      self.class.path
    end

    def service_definition_for(type_path)
      ServiceDefinition.new(self, type_path)
    end

    def list_service_definition_type_paths
      Dir.glob("#{path}/#{name}/**/*.yaml").map{ |file_path| file_path.sub("#{path}/#{name}/", '').split('/')[0..-2].join('/') }.sort
    end

    def service_definitions
      list_service_definition_type_paths.map do |type_path|
        ServiceDefinition.new( self, type_path )
      end
    end

    def pull
      stdout, stderr, status = Open3.capture3("git -C #{path}/#{name} pull")
      if status.exitstatus == 0
        true
      else
        @error_message = stderr.split('fatal: ')[1]
        false
      end
    end

    def delete
      FileUtils.rm_rf "#{path}/#{name}"
      FileUtils.rm_rf "#{path}_working_dir/#{name}"
    end

    def remote_url
      `git -C #{path}/#{name} remote get-url origin`
    end

  end
end

# module Settings
#   class ServiceDefinitionNamespace
#
#     require 'fileutils'
#     include ActiveModel::Model
#
#     def self.list
#       Dir.glob('repos/service_definitions/*').map{ |file_path| file_path.split("/").last }.sort
#     end
#
#     def self.all
#       list.map{ |name| new(name) }
#     end
#
#     def self.publisher_namespaces_collection
#       list
#     end
#
#     def self.type_paths_collection_for(publisher_name)
#       new(publisher_name).service_definitions.map &:type_path
#     end
#
#     def initialize(name)
#       # byebug
#       @name = name
#     end
#
#     attr_accessor :name
#     attr_reader :error_message
#
#     def path
#       @path ||= "repos/service_definitions/#{name}"
#     end
#
#     def service_definition_for(type_path)
#       ServiceDefinition.new(self, type_path)
#     end
#
#     def list_service_definition_type_paths
#       Dir.glob("#{path}/**/*.yaml").map{ |file_path| file_path.sub("#{path}/", '').split('/')[0..-2].join('/') }.sort
#     end
#
#     def service_definitions
#       list_service_definition_type_paths.map { |type_path| ServiceDefinition.new(self, type_path) }
#     end
#
#     def pull
#       stdout, stderr, status = Open3.capture3("git -C #{path} pull")
#       if status.exitstatus == 0
#         true
#       else
#         @error_message = stderr.split('fatal: ')[1]
#         false
#       end
#     end
#
#     def delete
#       FileUtils.rm_rf path
#     end
#
#     def exists?
#       File.directory? path
#     end
#
#     def remote_url
#       `git -C #{path} remote get-url origin`
#     end
#
#     def status
#       `git -C #{path} add . ; git -C #{path} status`.
#       sub( "  (use \"git push\" to publish your local commits)\n", '' ).
#       sub( "  (use \"git reset HEAD <file>...\" to unstage)\n", '' ).
#       sub("\n\n", "\n")
#     end
#
#     def log
#       `git -C #{path} log`
#     end
#
#     def uncommitted_diffs
#       @uncommitted_diffs ||= `git -C #{path} diff HEAD`
#     end
#
#     def committed_diffs
#       @committed_diffs ||= `git -C #{path} diff origin/master..HEAD`
#     end
#
#   end
# end
