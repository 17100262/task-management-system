class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
  # before_action :check_pass_changed

  private
  
  def check_pass_changed
    # byebug
    if current_user
      if ( not (params[:controller]=='users' and params[:action]== 'edit') and (not (params[:controller]=='users' and params[:action]== 'update'))) 
        # byebug
        if current_user.password_changed == false
          redirect_to edit_user_path(current_user), alert: "You must change your password before logging in for the first time"
        end
      end
    end
  end
end
