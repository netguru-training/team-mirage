module Admin
  class UsersController < Admin::ApplicationController
    expose(:users)
    expose(:user)

    def index
      self.users = User.all.page params[:page]
    end

    def destroy
      user.add_role :inactive
      redirect_to admin_users_path
    end
  end
end