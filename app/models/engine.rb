class Engine

  include ActiveModel::Model

  def self.all
    list.map{ |name| new(name: name) }
  end

  def self.list
    Engine::Repo.list(name.underscore.pluralize)
  end

  attr_accessor :name

  def initialize(params)
    @name = params[:name]
  end

  def readme
    @readme ||= Engine::Readme.new(self)
  end

  def release_notes
    @release_notes ||= Engine::ReleaseNotes.new(self)
  end

  def license
    @license ||= Engine::License.new(self)
  end

  def repo
    @repo ||= Engine::Repo.new(self)
  end

  def commit
    @commit ||= Engine::Commit.new(self)
  end

  def push
    @push ||= Engine::Push.new(self)
  end

end
