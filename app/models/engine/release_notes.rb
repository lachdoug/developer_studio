class Engine
  class ReleaseNotes

    include ActiveModel::Model

    attr_reader :engine

    def initialize(engine)
      @engine = engine
    end

    def file
      @file ||= engine.repo.release_notes
    end

    def save
      file.update content
    end

    def content
      @content ||= file.content
    end

    def update(params)
      @content = params[:content]
      save
    end

  end
end
