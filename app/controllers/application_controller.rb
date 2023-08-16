class ApplicationController < ActionController::Base
    def render_unauthorized(message:)
        render json: { error: "unauthorized", error_description: message }, status: :unauthorized
    end
end
