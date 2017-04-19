module Services
  module ReleaseNotes
    class ReleaseNotesController < BaseController

      def update
        @service.release_notes.update strong_params
        render body: nil
      end

      private

      def strong_params
        params.require(:engine_release_notes).permit(:content)
      end

    end
  end
end
