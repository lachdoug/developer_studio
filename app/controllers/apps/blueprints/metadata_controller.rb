module Apps
  module Blueprints
    class MetadataController < BaseController

      def update
        @app.blueprint.metadata.update strong_params
        render
      end

      private

      def strong_params
        params.require(:app_blueprint_metadata).permit(
          :blueprint_version_major,
          :blueprint_version_minor,
          :blueprint_version_level,
          :blueprint_version_patch,
          :software_display_title,
          :software_display_label,
          :software_display_version,
          :software_display_description,
          :software_display_url,
          :software_license_label,
          :software_license_url)
      end

    end
  end
end
