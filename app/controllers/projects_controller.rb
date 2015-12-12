class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]
  expose(:projects)
  expose(:project, attributes: :projects_params)

  def create
    project.owner = current_user
    if project.save
      redirect_to project_path(project), notice: 'Project has been created'
    else
      render :new
    end
  end

  def show
  end

  def index
  end

  private

  def projects_params
    params.require(:project).permit(:owner, :name, :description, :goal, :setup_date, :finish_date)
  end
end
