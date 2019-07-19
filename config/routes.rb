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
    namespace :blueprint, module: :blueprints do
      resource :metadata, only: [:update]
      resource :base, only: [:update]
      resource :scripts, only: [:update]
      resources :ports, only: [:new, :update, :destroy] do
        resource :moveup, module: :ports, only: [:show]
      end
      resources :external_repositories, only: [:new, :update, :destroy] do
        resource :moveup, module: :external_repositories, only: [:show]
      end
      resources :system_packages, only: [:new, :update, :destroy] do
        resource :moveup, module: :system_packages, only: [:show]
      end
      resources :installed_packages, only: [:new, :update, :destroy] do
        resource :moveup, module: :installed_packages, only: [:show]
      end
      resources :required_modules, only: [:new, :update, :destroy] do
        resource :moveup, module: :required_modules, only: [:show]
      end
      resources :service_configurations, only: [:new, :create, :update, :destroy] do
        resource :moveup, module: :service_configurations, only: [:show]
        resource :variables, module: :service_configurations, only: [:new]
        resource :publisher_namespace, module: :service_configurations, only: [:create]
        resource :type_path, module: :service_configurations, only: [:create]
      end
      resources :environment_variables, only: [:new, :update, :destroy] do
        resource :moveup, module: :environment_variables, only: [:show]
        resource :input, only: [], module: :environment_variables do
          resource :collection, only: [], module: :inputs do
            resources :items, only: [:new, :destroy], module: :collections do
              resource :moveup, only: [:show], module: :items
            end
          end
        end
      end
      resources :template_files, only: [:new, :update, :destroy] do
        resource :moveup, module: :template_files, only: [:show]
      end
      resources :replacement_strings, only: [:new, :update, :destroy] do
        resource :moveup, module: :replacement_strings, only: [:show]
      end
      resources :database_seed, only: [:new, :update, :destroy] do
        resource :moveup, module: :database_seed, only: [:show]
      end
      resources :file_write_permissions, only: [:new, :update, :destroy] do
        resource :moveup, module: :file_write_permissions, only: [:show]
      end
      resources :persistent_directories, only: [:new, :update, :destroy] do
        resource :moveup, module: :persistent_directories, only: [:show]
      end
      resources :persistent_files, only: [:new, :update, :destroy] do
        resource :moveup, module: :persistent_files, only: [:show]
      end
      resource :components, only: [:update] do
        resources :sources, module: :components, only: [:new, :update, :destroy] do
          resource :moveup, module: :sources, only: [:show]
        end
      end
      resource :workers, only: [:update] do
        resources :commands, module: :workers, only: [:new, :update, :destroy] do
          resource :moveup, module: :commands, only: [:show]
        end
      end
      resources :rake_tasks, only: [:new, :update, :destroy] do
        resource :moveup, module: :rake_tasks, only: [:show]
      end
      resources :custom_php_inis, only: [:new, :update, :destroy] do
        resource :moveup, module: :custom_php_inis, only: [:show]
      end
      resources :apache_htaccess_files, only: [:new, :update, :destroy] do
        resource :moveup, module: :apache_htaccess_files, only: [:show]
      end
      resources :apache_httpd_configurations, only: [:new, :update, :destroy] do
        resource :moveup, module: :apache_httpd_configurations, only: [:show]
      end
      resources :actionators, only: [:new, :update, :destroy] do
        resource :moveup, module: :actionators, only: [:show]
        resources :variables, only: [:new, :update, :destroy], module: :actionators do
          resource :moveup, module: :variables, only: [:show]
          resource :input, only: [], module: :variables do
            resource :collection, only: [], module: :inputs do
              resources :items, only: [:new, :destroy], module: :collections do
                resource :moveup, only: [:show], module: :items
              end
            end
          end
        end
      end
      resources :schedules, only: [:new, :update, :destroy] do
        resource :moveup, module: :schedules, only: [:show]
        resource :variables, module: :schedules, only: [:new]
      end
    end
    resource :readme, only: [:update], module: :readmes
    resource :release_notes, only: [:update], module: :release_notes
    resource :license, only: [:update], module: :licenses
  end

  resources :services, module: :services do
    resource :repository, only: [:show] do
      resource :commit, module: :repositories, only: [:create]
      resource :push, module: :repositories, only: [:show]
    end
    resource :service_definition, only: [:show] do
      resource :clone, module: :service_definitions, only: [:show]
      resource :update, module: :service_definitions, only: [:show]
      resource :commit, module: :service_definitions, only: [:create]
      resource :push, module: :service_definitions, only: [:show]
    end
    namespace :blueprint, module: :blueprints do
      resource :metadata, only: [:update]
      resource :base, only: [:update]
      resource :disposition, only: [:update]
      resource :scripts, only: [:update]
      resources :ports, only: [:new, :update, :destroy] do
        resource :moveup, module: :ports, only: [:show]
      end
      resources :external_repositories, only: [:new, :update, :destroy] do
        resource :moveup, module: :external_repositories, only: [:show]
      end
      resources :system_packages, only: [:new, :update, :destroy] do
        resource :moveup, module: :system_packages, only: [:show]
      end
      resources :installed_packages, only: [:new, :update, :destroy] do
        resource :moveup, module: :installed_packages, only: [:show]
      end
      resources :required_modules, only: [:new, :update, :destroy] do
        resource :moveup, module: :required_modules, only: [:show]
      end
      resources :included_files, only: [:new, :update, :destroy] do
        resource :moveup, module: :included_files, only: [:show]
      end
      resources :service_configurations, only: [:new, :create, :update, :destroy] do
        resource :moveup, module: :service_configurations, only: [:show]
        resource :variables, module: :service_configurations, only: [:new]
        resource :publisher_namespace, module: :service_configurations, only: [:create]
        resource :type_path, module: :service_configurations, only: [:create]
      end
      resources :environment_variables, only: [:new, :update, :destroy] do
        resource :moveup, module: :environment_variables, only: [:show]
        resource :input, only: [], module: :environment_variables do
          resource :collection, only: [], module: :inputs do
            resources :items, only: [:new, :destroy], module: :collections do
              resource :moveup, only: [:show], module: :items
            end
          end
        end
      end
      resources :constants, only: [:new, :update, :destroy] do
        resource :moveup, module: :constants, only: [:show]
      end
      resources :target_environment_variables, only: [:new, :update, :destroy] do
        resource :moveup, module: :target_environment_variables, only: [:show]
      end
      resources :template_files, only: [:new, :update, :destroy] do
        resource :moveup, module: :template_files, only: [:show]
      end
      resources :custom_files, only: [:new, :update, :destroy] do
        resource :moveup, module: :custom_files, only: [:show]
      end
      resources :replacement_strings, only: [:new, :update, :destroy] do
        resource :moveup, module: :replacement_strings, only: [:show]
      end
      resources :persistent_directories, only: [:new, :update, :destroy] do
        resource :moveup, module: :persistent_directories, only: [:show]
      end
      resource :consumers, only: [] do
        resources :accepts, module: :consumers, only: [:new, :update, :destroy] do
          resource :moveup, module: :accepts, only: [:show]
        end
      end
      resource :consumer_scripts, only: [:update]
      resources :consumer_params, only: [:new, :update, :destroy] do
        resource :moveup, module: :consumer_params, only: [:show]
        resource :input, only: [], module: :consumer_params do
          resource :collection, only: [], module: :inputs do
            resources :items, only: [:new, :destroy], module: :collections do
              resource :moveup, only: [:show], module: :items
            end
          end
        end
      end
      resources :actionators, only: [:new, :update, :destroy] do
        resource :moveup, module: :actionators, only: [:show]
        resources :variables, only: [:new, :update, :destroy], module: :actionators do
          resource :moveup, module: :variables, only: [:show]
          resource :input, only: [], module: :variables do
            resource :collection, only: [], module: :inputs do
              resources :items, only: [:new, :destroy], module: :collections do
                resource :moveup, only: [:show], module: :items
              end
            end
          end
        end
      end
      resources :configurators, only: [:new, :update, :destroy] do
        resource :moveup, module: :configurators, only: [:show]
        resources :variables, only: [:new, :update, :destroy], module: :configurators do
          resource :moveup, module: :variables, only: [:show]
          resource :input, only: [], module: :variables do
            resource :collection, only: [], module: :inputs do
              resources :items, only: [:new, :destroy], module: :collections do
                resource :moveup, only: [:show], module: :items
              end
            end
          end
        end
      end
      resources :schedules, only: [:new, :update, :destroy] do
        resource :moveup, module: :schedules, only: [:show]
        resource :variables, module: :schedules, only: [:new]
      end
      resources :service_dependencies, only: [:new, :update, :destroy] do
        resource :moveup, module: :service_dependencies, only: [:show]
      end
      resources :guises, only: [:new, :update, :destroy] do
        resource :moveup, module: :guises, only: [:show]
      end
      resource :capabilities, only: [:update]
      resources :log_directories, only: [:new, :update, :destroy] do
        resource :moveup, module: :log_directories, only: [:show]
      end
      resources :build_dependencies, only: [:new, :update, :destroy] do
        resource :moveup, module: :build_dependencies, only: [:show]
      end
      resources :file_permissions, only: [:new, :update, :destroy] do
        resource :moveup, module: :file_permissions, only: [:show]
      end
      resources :soft_links, only: [:new, :update, :destroy] do
        resource :moveup, module: :soft_links, only: [:show]
      end
      # resource :backup_scripts, only: [:update]
      # resources :library_scripts, only: [:new, :update, :destroy] do
      #   resource :moveup, module: :library_scripts, only: [:show]
      # end
    end
    resource :readme, only: [:update], module: :readmes
    resource :release_notes, only: [:update], module: :release_notes
    resource :license, only: [:update], module: :licenses
  end



end
