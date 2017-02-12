class App
  class Commit

    include ActiveModel::Model

    def initialize(app)
      @name = app.name
    end

    attr_accessor :message
    attr_reader :name, :error_message

    def commit(params)
      Repo::App.new(name).commit params[:message]
    rescue Rugged::NetworkError => e
      @error_message = e.message
      false
    end

  end
end
