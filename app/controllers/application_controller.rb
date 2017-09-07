class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :terms_and_conditions
  end

  def authenticate!
    return true if user_signed_in?
    respond_to do |format|
      format.js { render js:"window.location.href='#{new_user_session_path}'"}
      format.html { redirect_to new_user_session_path , :alert => 'no autorizado' }
    end
  end
end
