module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!, :authenticate_admin!

    private
    def authenticate_admin!
      return if current_user.admin?
      flash[:alert] = "You are not an admin!"
      redirect_to root_path
    end
  end
end
