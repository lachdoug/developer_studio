class Service
  class ServiceBlueprint
    class TargetEnvironmentVariable < ::Blueprint::SectionCollectionItem

      form_attributes :variable_name, :environment_variable_name

      # def to_s
      #   string || 'New'
      # end

    end
  end
end
