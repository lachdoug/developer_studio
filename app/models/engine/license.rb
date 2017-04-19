class Engine
  class License

    include ActiveModel::Model

    attr_reader :engine

    def initialize(engine)
      @engine = engine
    end

    def file
      @file ||= engine.repo.license
    end

    def save
      file.update content
    end

    def content
      @content ||= file.repository_license
    end

    def update(params)
      @content = params[:content]
      save
    end

  end
end
