class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
  helper_method :current_user

  # This can be used to provide a detailed map of routes supported by the API.
  def main
  	render json: {:message => "You might want to try /stores or  /purchase_orders"}
  end

  # To bypass CSRF verification for API requests, requests with "Content-Type" header containing the value "application/json" are considered.
  # This is arguably not the best option to go about it. However, for initial testing it would suffice. The ideal approach here would be to pass
  # some value from the client to differentiate API clients versus actual web clients.
  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      user_id = User.authenticate_user(username, password)
      if user_id > 0
        session[:user_id] = user_id
      else
        respond_to do |format|
          format.xml{  render :xml => 'Access Denied',  :status => 403 }
          format.json{ render :json => 'Access Denied', :status => 403 }
          format.html{ render :json => 'Access Denied', :status => 403 }
        end
      end
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
