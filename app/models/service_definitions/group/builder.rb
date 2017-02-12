module ServiceDefinitions
  class Group
    class Builder

      require 'rugged'
      require 'fileutils'
      include ActiveModel::Model

      def self.create(params)
        new(params[:url]).tap(&:clone_remote)
      end

      def initialize(url=nil)
        @url = url
      end

      attr_accessor :url

      def clone_remote
        Rugged::Repository.clone_at url, "repos/service_definitions/#{name}"
      end

      def name
        @name ||= url.split('/').last.split('.').first
      end

    end
  end
end
