class Service
  class ServiceBuilder < ::Engine::BuilderBase

    def clone_remote
      Engine::Repo.clone url, :services
    end

  end
end
