Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end



  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resource :settings, module: :settings do
    resource :dropdowns_config
    resources :service_definition_namespaces
  end

  resources :apps, module: :apps do
    resource :repository, only: [:show] do
      resource :commit, module: :repositories, only: [:create]
      resource :push, module: :repositories, only: [:show]
    end
    # resource :app_create_type, only: [:new, :create]
    namespace :blueprint, module: :blueprints do
      resource :metadata, only: [:update]
      resource :base, only: [:update]
      resource :scripts, only: [:update]
      resource :database_seed, only: [:update]
      resource :components, only: [:update] do
        resource :source, only: [:new, :destroy], module: :components
      end
      resource :persistent_directories, only: [:new, :update] do
        resource :persistent_directory, only: [:destroy]
      end
      resource :service_configurations, only: [:new, :update, :destroy] do
        resource :variables_builder, only: [:new], module: :service_configurations
      end
      resource :replacement_strings, only: [:new, :update] do
        resource :replacement_string, only: [:destroy]
      end
      resource :persistent_files, only: [:new, :update] do
        resource :persistent_file, only: [:destroy]
      end
      resource :installed_packages, only: [:new, :update] do
        resource :installed_package, only: [:destroy]
      end
      resource :system_packages, only: [:new, :update] do
        resource :system_package, only: [:destroy]
      end
      resource :workers, only: [:update] do
        resource :command, only: [:new, :destroy], module: :workers
      end
      resource :rake_tasks, only: [:new, :update] do
        resource :rake_task, only: [:destroy]
      end
      resource :template_files, only: [:new, :update] do
        resource :template_file, only: [:destroy]
      end
      resource :file_write_permissions, only: [:new, :update] do
        resource :file_write_permission, only: [:destroy]
      end
      resource :custom_php_inis, only: [:new, :update] do
        resource :custom_php_ini, only: [:destroy]
      end
      resource :apache_htaccess_files, only: [:new, :update] do
        resource :apache_htaccess_file, only: [:destroy]
      end
      resource :apache_httpd_configurations, only: [:new, :update] do
        resource :apache_httpd_configuration, only: [:destroy]
      end
      resource :required_modules, only: [:new, :update] do
        resource :required_module, only: [:destroy]
      end
      resource :ports, only: [:new, :update] do
        resource :port, only: [:destroy]
      end
      resource :actionator, only: [:new, :update, :destroy] do
        resource :variable, only: [:new, :destroy], module: :actionators do
          resource :input_collection_item, only: [:new, :destroy], module: :variables
        end
      end
      resource :external_repositories, only: [:new, :update] do
        resource :external_repository, only: [:destroy]
      end
      resource :environment_variables, only: [:new, :update] do
        resource :environment_variable, only: [:destroy] do
          resource :input, only: [], module: :environment_variables do
            resource :collection, only: [], module: :inputs do
              resource :items, only: [:new], module: :collections do
                resource :item, only: [:destroy]
              end
            end
          end
        end
      end
    end
    resource :readme, only: [:update], module: :readmes
    resource :release_notes, only: [:update], module: :release_notes
    resource :license, only: [:update], module: :licenses
  end

  resources :services, module: :services do
    # resource :author
  end

end
