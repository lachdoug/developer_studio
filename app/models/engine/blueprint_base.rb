class Engine
  class BlueprintBase

    attr_reader :engine

    def initialize(engine)
      @engine = engine
    end

    def file
      @file ||= engine.repo.blueprint
    end

    def save
      @content = file.update content
    end

    def content
      @content ||= file.content
    end

    def update(new_content)
      @content = new_content
      save
    end

  end
end
