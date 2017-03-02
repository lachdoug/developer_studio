module Settings
  class ServiceDefinitionNamespace

    require 'fileutils'
    include ActiveModel::Model

    def self.list
      Dir.glob('repos/service_definitions/*').map{ |file_path| file_path.split("/").last }.sort
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

    def service_definition_for(type_path)
      ServiceDefinition.new(self, type_path)
    end

    def list_service_definition_type_paths
      Dir.glob("repos/service_definitions/#{name}/**/*.yaml").map{ |file_path| file_path.sub("repos/service_definitions/#{name}/", '').split('/')[0..-2].join('/') }.sort
    end

    def service_definitions
      list_service_definition_type_paths.map { |type_path| ServiceDefinition.new(self, type_path) }
    end

    def pull
      stdout, stderr, status = Open3.capture3("git -C repos/service_definitions/#{name} pull")
      if status.exitstatus == 0
        true
      else
        @error_message = stderr.split('fatal: ')[1]
        false
      end
    end

    def delete
      FileUtils.rm_rf "repos/service_definitions/#{name}"
    end

  end
end
