class App
  class Blueprint
    class ExternalRepositories < Section

      attr_reader :external_repositories

      def data_location
        [ :software, :external_repositories ]
      end

      def load_data
        self.external_repositories_attributes = external_repositories_persisted_data
      end

      def external_repositories_persisted_data
        persisted_data.map.with_index do |external_repository, i|
          { i.to_s => external_repository }
        end.inject(:merge) || {}
      end

      def external_repositories_attributes=(params)
        @external_repositories = params.map { |i, external_repository_params| ExternalRepository.new external_repository_params }
      end

      def build_external_repository
        @external_repositories << ExternalRepository.new
      end

      def form_data
        external_repositories.map &:form_data
      end

      def delete(i)
        external_repositories.delete_at i
        save
      end

    end
  end
end
