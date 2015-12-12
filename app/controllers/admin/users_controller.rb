module Admin
  class UsersController < Admin::ApplicationController
    expose(:users)

    def index
      self.users = User.all.page params[:page]
    end
  end
end