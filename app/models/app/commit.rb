class App
  class Commit

    include ActiveModel::Model

    def initialize(app)
      @name = app.name
    end

    attr_accessor :message
    attr_reader :name, :error_message

    def commit(params)
      commit_result = Repo::App.new(name).commit params[:message]
      if commit_result[:success]
        true
      else
        @error_message = commit_result[:message]
        false
      end
    end

  end
end
