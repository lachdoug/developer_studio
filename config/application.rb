require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DeveloperStudio
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.public_key = File.read("#{Dir.home}/.ssh/identity.pub")
    config.persistent_data_directory = ENV['EDS_PERSISTENT_DATA_DIRECTORY'] || "../developer_studio_persistent_data"

    # Create any missing data directories
    Dir.mkdir "#{config.persistent_data_directory}/repos" unless File.directory? "#{config.persistent_data_directory}/repos"
    Dir.mkdir "#{config.persistent_data_directory}/repos/apps" unless File.directory? "#{config.persistent_data_directory}/repos/apps"
    Dir.mkdir "#{config.persistent_data_directory}/repos/services" unless File.directory? "#{config.persistent_data_directory}/repos/services"
    Dir.mkdir "#{config.persistent_data_directory}/repos/service_definitions" unless File.directory? "#{config.persistent_data_directory}/repos/service_definitions"
    Dir.mkdir "#{config.persistent_data_directory}/repos/service_definitions_working_dir" unless File.directory? "#{config.persistent_data_directory}/repos/service_definitions_working_dir"

  end
end
