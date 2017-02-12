class App
  class Blueprint
    class Components
      class Source

        include ActiveModel::Model

        attr_accessor :label, :url
        attr_reader :install_script

        def install_script_attributes=(params)
          @install_script = InstallScript.new(params)
        end

        def form_data
          {
            label: label,
            url: url,
            install_script: install_script.form_data
          }
        end

      end
    end
  end
end
