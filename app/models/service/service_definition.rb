class Service
  class ServiceDefinition

    attr_reader :engine

    def initialize(engine)
      @engine = engine
    end

    def publisher_namespace
      @publisher_namespace ||= engine.blueprint.base.publisher_namespace
    end

    def type_path
      @type_path ||= engine.blueprint.base.type_path
    end

    def commit
      @commit ||= ::Service::ServiceDefinition::Commit.new(self)
    end

    def push
      @push ||= ::Service::ServiceDefinition::Push.new(self)
    end

    def repo
      @repo ||= ::Service::ServiceDefinition::Repo.new(self)
    end

    def yaml_from_blueprint
      @yaml_from_blueprint ||= engine.blueprint.service_definition.deep_stringify_keys.to_yaml
    end

    def needs_update?
      yaml_from_blueprint != repo.file_content
    end

    def settings_remote_url
      Settings::ServiceDefinitionNamespace.new( publisher_namespace ).remote_url.strip
    end

  end
end
