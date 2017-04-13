class App
  class Push

    include ActiveModel::Model

    def initialize(app)
      @name = app.name
    end

    # attr_accessor :username, :password
    attr_reader :name, :error_message

    def push #(params)
      push_result = Repo::App.new(name).push # params[:username], params[:password]
      if push_result[:success]
        true
      else
        @error_message = push_result[:message]
        false
      end
    end

  end
end
