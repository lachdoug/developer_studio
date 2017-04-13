class App

  include ActiveModel::Model

  attr_accessor :name

  def initialize(params)
    @name = params[:name]
  end

  def self.list
    Repo::App.list
  end

  def self.all
    list.map{ |name| new(name: name) }
  end

  def blueprint
    @blueprint ||= App::Blueprint.new(self)
  end

  def readme
    @readme ||= App::Readme.new(self)
  end

  def release_notes
    @release_notes ||= App::ReleaseNotes.new(self)
  end

  def license
    @license ||= App::License.new(self)
  end

  def repository
    @repository ||= Repo::App.new(name)
  end

  def delete
    FileUtils.rm_rf("repos/apps/#{name}")
  end

end
