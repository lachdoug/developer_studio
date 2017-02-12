module Repo
  class App
    class Blueprint
      module Conform

        def self.json(raw_blueprint_string)
          raw_blueprint = parsed_json_for(raw_blueprint_string)
          major = raw_blueprint.dig(:schema, :version, :major).to_i
          minor = raw_blueprint.dig(:schema, :version, :minor).to_i
          raise BlueprintSchemaVersionError if major > 1 || ( major == 1 && minor > 0 )
          return BetaBlueprintToSchema1_0.new(raw_blueprint).output if major < 1
          Schema1_0.new(raw_blueprint).output
        end

        def self.parsed_json_for(raw_blueprint_string)
          JSON.parse(raw_blueprint_string).deep_symbolize_keys
        rescue
          {}
        end

      end
    end
  end
end
