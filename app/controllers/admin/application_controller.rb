module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!, :authenticate_admin!

    def authenticate_admin!
      unless current_user.admin?
        flash[:alert] = "You are not an admin!"
        redirect_to root_path
      end
    end
  end
end