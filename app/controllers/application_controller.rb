class ApplicationController < ActionController::API
    before_action :set_csrf_cookie
    include ActionController::Cookies
    skip_before_action :verify_authenticity_token
    before_action :authorize

    def cookie 
        "ok"
    end
  
    private

    def set_csrf_cookie
       cookies["CSRF-TOKEN"] = {
            value: form_authenticity_token
        }
    end
  
    def authorize
      @current_user = User.find_by(id: session[:user_id])
  
      render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
    end
  
    def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
