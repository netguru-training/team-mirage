module Admin
  class InvitationsController < Admin::ApplicationController
    expose(:user)

    def create
      if User.find_by(email: params[:user][:email])
        flash[:alert] = "User with given email is registered or has been "+
                        "already invited!"
        render :new
      else
        user = User.invite!(user_params) do |u|
          u.skip_invitation = true
        end
        if user.save
          User.invite!(email: user.email)
          flash[:notice] = "Invitation sent successfully"
          redirect_to admin_users_path
        else
          flash[:alert] = "There were problems with sending an invitation"
          render :new
        end
      end
    end

    private
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :occupation, :country, role_ids: [])
    end
  end
end
