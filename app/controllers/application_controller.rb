class ApplicationController < ActionController::API
    before_action :set_csrf_cookie
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
    protect_from_forgery with: :exception, prepend: true
    
    before_action :authorize

    before_filter :cor
  

    def cookie 
        render json:{ ok: :ok, csrf: form_authenticity_token }
    end
  
    private

    def cor
      headers["Access-Control-Allow-Origin"]  = "*"
      headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
      headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
      head(:ok) if request.request_method == "OPTIONS"
    end 

    def set_csrf_cookie
       cookies["CSRF-TOKEN"] = {
            value: form_authenticity_token,
            secure: true,
            same_site: "None",
            domain: :all 
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
