module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!, :authenticate_admin!

    def authenticate_admin!
      if current_user
        unless current_user.admin?
          flash[:alert] = "You are not an admin!"
          redirect_to root_path
        end
      else
        redirect_to new_user_session_path
      end
    end
  end
end