class Service
  class ServiceBlueprint
    class Metadata < ::Blueprint::Section

      attr_accessor :blueprint_version_major,
                    :blueprint_version_minor,
                    :blueprint_version_level,
                    :blueprint_version_patch,
                    :software_display_title,
                    :software_display_label,
                    :software_display_version,
                    :software_display_description,
                    :software_display_url,
                    :software_license_label,
                    :software_license_url

      def data_location
        [ :metadata ]
      end

      def build_section
        @blueprint_version_major = data.dig :blueprint, :version, :major
        @blueprint_version_minor = data.dig :blueprint, :version, :minor
        @blueprint_version_level = data.dig :blueprint, :version, :level
        @blueprint_version_patch = data.dig :blueprint, :version, :patch
        @software_display_title = data.dig :software, :display, :title
        @software_display_label = data.dig :software, :display, :label
        @software_display_version = data.dig :software, :display, :version
        @software_display_description = data.dig :software, :display, :description
        @software_display_url = data.dig :software, :display, :url
        @software_license_label = data.dig :software, :license, :label
        @software_license_url = data.dig :software, :license, :url
      end

      def form_data
        {
          blueprint: {
            version: {
              major: blueprint_version_major.to_i,
              minor: blueprint_version_minor.to_i,
              level: blueprint_version_level,
              patch: blueprint_version_patch.to_i
            }
          },
          software: {
              display: {
                title: software_display_title,
                label: software_display_label,
                version: software_display_version,
                description: software_display_description,
                url: software_display_url
              },
              license: {
                label: software_license_label,
                url: software_license_url
              }
          }
        }
      end

      def blueprint_version_level_select_collection
        [ :alpha, :beta, :rc, :release ]
      end

    end
  end
end
