class CommentsController < ApplicationController
  expose(:project)
  expose(:comments, ancestor: :project)
  expose(:comment, attributes: :comment_params)

  def create
    comment.user = current_user

    if comment.save
      redirect_to project_path(project), notice: 'Your comment was added successfully. Thank you!'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user, :project, :body)
  end
end