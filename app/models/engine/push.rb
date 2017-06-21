class Engine
  class Push

    # include ActiveModel::Model

    def initialize(engine)
      @engine = engine
    end

    # attr_accessor :username, :password
    attr_reader :engine, :error_message

    def do_push #(params)
      push_result = engine.repo.push # params[:username], params[:password]
      if push_result[:success]
        true
      else
        @error_message = push_result[:message].gsub('hint: ', '')
        false
      end
    end

  end
end
