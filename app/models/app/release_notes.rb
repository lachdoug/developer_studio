class App
  class ReleaseNotes

    include ActiveModel::Model

    attr_reader :app

    def initialize(app)
      @app = app
    end

    def file
      @file ||= app.repository.release_notes
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
