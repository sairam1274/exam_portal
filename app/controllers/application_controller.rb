class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def authenticate_admin_user
    redirect_to root_path, :alert => "Not authorized to access this page." unless current_user.has_role?("admin")
  end

end
