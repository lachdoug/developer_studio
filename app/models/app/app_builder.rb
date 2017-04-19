class App
  class AppBuilder < ::Engine::BuilderBase

    def clone_remote
      Engine::Repo.clone url, :apps
    end

  end
end
