class Engine
  class BuilderBase

    include ActiveModel::Model

    def build(params)
      assign_attributes(params)
      result = clone_remote
      if result[:success] == true
        true
      else
        @error_message = result[:message].gsub('hint: ', '')
        false
      end
    end

    attr_reader :url, :error_message

    def url=(url)
      @url = url
    end

    def name
      @name ||= url.split('/').last.split('.').first
    end

  end
end
