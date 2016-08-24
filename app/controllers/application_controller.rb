class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!, except: :location
  before_filter :update_sanitized_params, if: :devise_controller?
  protect_from_forgery with: :exception





  def location

    if params[:location_accepted] == "true"
      session[:location_accepted] = true
      session[:last_location_update] = Time.now
      session[:lat] = params["lat"]
      session[:lng] = params["lng"]
      session[:accuracy] = params["accuracy"]
      render json: { :lat => session[:lat], :lng => session[:lng], accuracy: session[:accuracy], location_accepted: session[:location_accepted] }
    else
      session[:location_accepted] = false
      session[:last_location_update] = Time.now
      session[:lat] = nil
      session[:lng] = nil
      session[:accuracy] = nil
      render json: { :location_accepted => "false" }
    end
  end

  protected

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo])
  end

end

