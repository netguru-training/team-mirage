class RatingsController < ApplicationController
  expose(:project)
  expose(:ratings, ancestor: :project)
  expose(:rating, attributes: :rating_params)

  def create
    rating.user = current_user

    if rating.save
      redirect_to project_path(project), notice: 'Your rating was added successfully. Thank you!'
    else
      redirect_to project_path(project), alert: 'There was something wrong with your rating.'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:project, :value)
  end
end