module Admin
  class UsersController < Admin::ApplicationController
    expose(:users)
    expose(:user)

    def index
      self.users = User.all.page params[:page]
    end


    def create
      user = User.new user_params
      if user.save
        flash[:notice] = "User created!"
        redirect_to admin_users_path
      else
        flash[:error] = "There were errors with creating user"
        redirect_to new_admin_user_path
      end
    end

    def update
      self.user.update user_params
      if user.save
        flash[:notice] = "User updated!"
        redirect_to admin_users_path
      else
        flash[:error] = "There were errors with updating user"
        render :edit
      end
    end

    def destroy
      user.add_role :inactive
      redirect_to admin_users_path
    end

    private
    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :occupation, :country, role_ids: [])
    end
  end
end