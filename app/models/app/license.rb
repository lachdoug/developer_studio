class App
  class License

    include ActiveModel::Model

    attr_reader :app

    def initialize(app)
      @app = app
    end

    def file
      @file ||= app.repository.license
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
