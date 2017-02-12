class App
  class Builder

    include ActiveModel::Model

    def build(params)
      assign_attributes(params)
      result = clone_remote
      if result[:success] == true
        true
      else
        @error_message = result[:message]
        false
      end
    end

    # attr_accessor :url
    attr_reader :url, :error_message

    def url=(input_value)
      @url = input_value.sub('https://', 'ssh://')
    end

    def clone_remote
      Repo::App.clone url
    end

    def name
      @name ||= url.split('/').last.split('.').first
    end

  end
end
