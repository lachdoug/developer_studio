module Conform
  class Base

    def initialize(data)
      @data = data
    end

    def major
      @data.dig(:schema, :version, :major).to_i
    end

    def minor
      @data.dig(:schema, :version, :minor).to_i
    end

    def Schema_1_0
      raise EnginesError.new "#{self.class.to_s.titleize} schema version error." if major > 1 || ( major == 1 && minor > 0 )
      @data = self.class::Schema_0_0ToSchema_1_0.new(@data).output if @data.present? && major < 1
      self.class::Schema_1_0.new(@data).output
    end

  end
end
