class Engine
  class Readme

    include ActiveModel::Model

    attr_reader :engine

    def initialize(engine)
      @engine = engine
    end

    def file
      @file ||= engine.repo.readme
    end

    def save
      file.update content
    end

    def content
      @content ||= file.content
    end

    def update(params)
      # byebug
      @content = params[:content]
      save
    end

  end
end
