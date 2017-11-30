module Services
  module Blueprints
    module SoftLinks
      class MoveupsController < BaseController

        def show
          @service.blueprint.soft_links.moveup params[:soft_link_id]
          render
        end

      end
    end
  end
end
