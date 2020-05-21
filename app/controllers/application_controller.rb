class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from UncaughtThrowError do |e|
    redirect_to root_path if e.tag == :warden
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:username, :avatar, :first_name, :last_name, :bio])

    devise_parameter_sanitizer.permit(:account_update, :keys => [:username, :avatar, :first_name, :last_name, :bio])
  end
end
