class Service
  class ServiceDefinitionRepo

    attr_reader :engine

    def initialize(engine)
      @engine = engine
    end

    def publisher_namespace
      @publisher_namespace ||= engine.blueprint.base.publisher_namespace
    end

    def type_path
      @type_path ||= engine.blueprint.base.type_path
    end

    def commit
      @commit ||= ::Service::ServiceDefinitionRepo::Commit.new(self)
    end

    def push
      @push ||= ::Service::ServiceDefinitionRepo::Push.new(self)
    end

    def path
      @path ||= "repos/service_definitions/#{publisher_namespace}"
    end

    def file_path
      "#{type_path}/#{type_path.split('/').last}.yaml"
    end

    def exists?
      File.directory? path
    end

    def remote_url
      `git -C #{path} remote get-url origin`
    end

    def status
      `git -C #{path} add . ; git -C #{path} status`.
      sub( "  (use \"git push\" to publish your local commits)\n", '' ).
      sub( "  (use \"git reset HEAD <file>...\" to unstage)\n", '' ).
      sub("\n\n", "\n")
    end

    def log
      `git -C #{path} log`
    end

    def uncommitted_diffs
      @uncommitted_diffs ||= `git -C #{path} diff HEAD`
    end

    def committed_diffs
      @committed_diffs ||= `git -C #{path} diff origin/engines_developer_studio..HEAD`
    end

    def master_content
      @master_content ||= repository_master_branch_service_definition
    end

    def eds_content
      @eds_content ||= repository_eds_branch_service_definition
    end

    def repository_master_branch_service_definition
      # byebug
      `git -C #{path} checkout -B master`
      File.read "#{path}/#{file_path}"
    rescue Errno::ENOENT # no file error
      ''
    end

    def repository_eds_branch_service_definition
      # byebug
      `git -C #{path} checkout -B engines_developer_studio`
      File.read "#{path}/#{file_path}"
    rescue Errno::ENOENT # no file error
      ''
    end

    def yaml_from_blueprint
      @yaml_from_blueprint ||= engine.blueprint.service_definition.deep_stringify_keys.to_yaml
    end

    def needs_update?
      yaml_from_blueprint != eds_content
    end

    def update
      File.write "#{path}/#{file_path}", yaml_from_blueprint
      `git -C #{path} add -A`
    end

    def do_commit(message)
      `git -C #{path} checkout -B engines_developer_studio`
      update
      stdout, stderr, status = Open3.capture3("git -C #{path} commit -m '#{message}'")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr }
      end
    end

    def do_push
      # byebug
      `git -C #{path} checkout -B engines_developer_studio`
      stdout, stderr, status = Open3.capture3("git -C #{path} push -f origin engines_developer_studio")
      if status.exitstatus == 0
        { success: true }
      else
        { success: false, message: stderr }
      end
    end

    # def blueprint
    #   @engine.blueprint
    # end


    # def file
    #   @file ||= engine.repo.blueprint
    # end
    #
    # def save
    #   @content = file.update content
    # end
    #
    # def content
    #   @content ||= file.content
    # end
    #
    # def update(new_content)
    #   @content = new_content
    #   save
    # end


    # def yaml_from_blueprint
    #   {
    #     publisher_namespace: blueprint.base.publisher_namespace,
    #     type_path: blueprint.base.type_path,
    #     accepts: blueprint.base.accepts.form_data,
    #     title: blueprint.metadata.software_display_title,
    #     description: blueprint.metadata.software_display_description,
    #     major: blueprint.metadata.blueprint_version_major,
    #     minor: blueprint.metadata.blueprint_version_minor,
    #     release_level: blueprint.metadata.blueprint_version_level,
    #     patch: blueprint.metadata.blueprint_version_patch,
    #     service_container: blueprint.base.name,
    #     service_handle_field: blueprint.base.service_handle_field,
    #     dedicated: blueprint.base.dedicated,
    #     persistent: blueprint.base.persistent,
    #     immutable: blueprint.base.immutable,
    #     attach_post_build: blueprint.base.attach_post_build,
    #     attach_requires_restart: blueprint.base.attach_requires_restart,
    #     soft_service: blueprint.base.soft_service,
    #     target_environment_variables: blueprint.target_environment_variables.form_data.map{ |v| { v[:variable_name].to_sym => v } }.inject(:merge),
    #     consumer_params: blueprint.consumer_params.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge),
    #     type_consumer_params: "blueprint.type_consumer_params.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge)",
    #     configurators: blueprint.configurators.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge),
    #     service_actionators: blueprint.actionators.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge),
    #     constants: blueprint.constants.form_data.map{ |v| { v[:name].to_sym => v } }.inject(:merge)
    #   }.deep_stringify_keys.to_yaml
    # end



  end
end
