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
      # byebug
      case push_result
      when 'rejected'
        @error_message = "Remote repo rejected push."
        return false
      when 'up to date'
        @error_message = "Already up-to-date."
        return false
      when 'done'
        return true
      else
        @error_message = "Unhandled error."
        return false
      end
    end

  end
end
