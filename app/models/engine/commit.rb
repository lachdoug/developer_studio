class Engine
  class Commit

    include ActiveModel::Model

    def initialize(engine)
      @engine = engine
    end

    attr_accessor :message
    attr_reader :engine, :error_message

    def do_commit(params)
      commit_result = engine.repo.commit params[:message]
      if commit_result[:success]
        true
      else
        @error_message = commit_result[:message].gsub('hint: ', '')
        false
      end
    end

  end
end
