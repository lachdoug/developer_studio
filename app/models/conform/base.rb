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

    def Schema_0_1
      raise EnginesError.new "#{self.class.to_s.titleize} schema version error." if major > 1 || ( major == 1 && minor > 0 )
      @data = self.class::Schema_0_0ToSchema_0_1.new(@data).output if @data.present? && major.nil?
      self.class::Schema_0_1.new(@data).output
    end

  end
end
