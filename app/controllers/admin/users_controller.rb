module Admin
  class UsersController < Admin::ApplicationController
    expose(:users)
    expose(:user)

    def index
      self.users = User.all.page params[:page]
    end
  end
end