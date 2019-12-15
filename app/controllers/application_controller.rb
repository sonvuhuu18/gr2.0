class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to get_root_path
  end

  private

  def authenticate_admin!
    unless current_user.admin? || current_user.trainer?
      redirect_to root_path
    end
  end

  def after_sign_in_path_for resource
    get_root_path
  end

  def after_sign_out_path_for resource
    new_user_session_path
  end

  def access_denied exception
    redirect_to get_root_path, alert: exception.message
  end

  def get_root_path
    current_user.admin? || current_user.trainer? ? admin_root_path : root_path
  end
end
