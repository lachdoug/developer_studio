class App
  class Builder < ::Engine::Builder

    def clone_remote
      Engine::Repo.clone url, :apps
    end

  end
end
