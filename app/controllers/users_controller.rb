class UsersController < ApplicationController
  before_filter :authenticate_user!

  expose(:user, attributes: :user_params)
  def show
  end

  def update
    if current_user==user && user.save 
      redirect_to user_path(user), notice: 'Your profile has been updated'
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end


end
