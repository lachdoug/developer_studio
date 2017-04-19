class Service
  class Builder < ::Engine::Builder

    def clone_remote
      Engine::Repo.clone url, :services
    end

  end
end
