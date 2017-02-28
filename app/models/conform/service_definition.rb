module Conform
  class ServiceDefinition

    def initialize(original_service_definition)
      @original_service_definition = original_service_definition
    end

    def major
      @original_service_definition.dig(:schema, :version, :major).to_i
    end

    def minor
      @original_service_definition.dig(:schema, :version, :minor).to_i
    end

    def json
      raise ServiceDefinitionSchemaVersionError if major > 1 || ( major == 1 && minor > 0 )
      return Schema_0_0ToSchema_1_0.new(@original_service_definition).output if major < 1
      Schema_1_0.new(@original_service_definition).output
    end

  end
end
