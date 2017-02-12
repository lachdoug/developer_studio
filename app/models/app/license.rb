class App
  class License

    include ActiveModel::Model

    def initialize(app)
      @app = app
    end

    attr_reader :app

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
