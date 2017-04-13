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


      #   resource :external_repositories, only: [:new, :update] do
      #     resource :external_repository, only: [:destroy]
      #   end






    #   resource :database_seed, only: [:update]
    #   resource :components, only: [:update] do
    #     resource :source, only: [:new, :destroy], module: :components
    #   end
    #   resource :persistent_directories, only: [:new, :update] do
    #     resource :persistent_directory, only: [:destroy]
    #   end
    #   resources :service_configurations, only: [:new, :create, :update, :destroy] do
    #     # resource :type_path, only: [:create], module: :service_configurations
    #     resource :variables_builder, only: [:new], module: :service_configurations
    #   end
    #   resource :replacement_strings, only: [:new, :update] do
    #     resource :replacement_string, only: [:destroy]
    #   end
    #   resource :persistent_files, only: [:new, :update] do
    #     resource :persistent_file, only: [:destroy]
    #   end
    #   resource :installed_packages, only: [:new, :update] do
    #     resource :installed_package, only: [:destroy]
    #   end
    #   resource :system_packages, only: [:new, :update] do
    #     resource :system_package, only: [:destroy]
    #   end
    #   resource :workers, only: [:update] do
    #     resource :command, only: [:new, :destroy], module: :workers
    #   end
    #   resource :rake_tasks, only: [:new, :update] do
    #     resource :rake_task, only: [:destroy]
    #   end
    #   resource :template_files, only: [:new, :update] do
    #     resource :template_file, only: [:destroy]
    #   end
    #   resource :file_write_permissions, only: [:new, :update] do
    #     resource :file_write_permission, only: [:destroy]
    #   end
    #   resource :custom_php_inis, only: [:new, :update] do
    #     resource :custom_php_ini, only: [:destroy]
    #   end
    #   resource :apache_htaccess_files, only: [:new, :update] do
    #     resource :apache_htaccess_file, only: [:destroy]
    #   end
    #   resource :apache_httpd_configurations, only: [:new, :update] do
    #     resource :apache_httpd_configuration, only: [:destroy]
    #   end
    #   resource :required_modules, only: [:new, :update] do
    #     resource :required_module, only: [:destroy]
    #   end
    #   resource :ports, only: [:new, :update] do
    #     resource :port, only: [:destroy]
    #   end
    #   resource :actionator, only: [:new, :update, :destroy] do
    #     resource :variable, only: [:new, :destroy], module: :actionators do
    #       resource :input_collection_item, only: [:new, :destroy], module: :variables
    #     end
    #   end
    #   resource :environment_variables, only: [:new, :update] do
    #     resource :environment_variable, only: [:destroy] do
    #       resource :input, only: [], module: :environment_variables do
    #         resource :collection, only: [], module: :inputs do
    #           resource :items, only: [:new], module: :collections do
    #             resource :item, only: [:destroy]
    #           end
    #         end
    #       end
    #     end
    #   end
    #   resource :schedules, only: [:new, :update] do
    #     resource :schedule, only: [:destroy]
    #     resource :variables_builder, only: [:new], module: :schedules
    #   end
    end
    resource :readme, only: [:update], module: :readmes
    resource :release_notes, only: [:update], module: :release_notes
    resource :license, only: [:update], module: :licenses
  end

  resources :services, module: :services do
    # resource :author
  end

end
