class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  expose(:active_projects) {Project.ongoing}
  expose(:remaining_projects) {Project.remaining}
  expose(:projects)
  expose(:project, attributes: :projects_params)

  def create
    project.owner = current_user

    if project.save
      set_project_status
      redirect_to project_path(project), notice: 'Project has been created'
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if project.save
      redirect_to project_path(project), notice: 'Your project has been updated'
    else
      render :edit
    end
  end

  def index
  end

  private

  def projects_params
    params.require(:project).permit(:owner, :name, :description, :goal, :setup_date, :finish_date)
  end

  def set_project_status
    if project.setup_date == Date.today
      project.active!
    else
      project.waiting!
    end
  end
end
