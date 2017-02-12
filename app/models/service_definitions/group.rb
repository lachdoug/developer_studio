module ServiceDefinitions
  class Group

    require 'fileutils'
    include ActiveModel::Model

    def self.list
      Dir.glob('repos/service_definitions/*').map{ |file_path| file_path.split("/").last }.sort
    end

    def self.all
      list.map{ |name| new(name) }
    end

    def self.publishers_collection
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
      system "git -C repos/service_definitions/#{name} pull"
    end

    def delete
      FileUtils.rm_rf "repos/service_definitions/#{name}"
    end

  end
end
