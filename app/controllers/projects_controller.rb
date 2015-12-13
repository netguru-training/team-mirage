class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  expose(:active_projects) { Project.active }
  expose(:remaining_projects)  { Project.inactive }
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
    daily_payments=Hash.new(0)
    total_payments = Hash.new(0)
    total_funds=0
    @hash_limit = {}
    project.payments.order(:created_at).map do |x|
      daily_payments["#{project.setup_date.strftime('%d %b %y')}"] = 0
      daily_payments["#{x.created_at.strftime('%d %b %y')}"] += x.value
      total_funds += x.value
      total_payments["#{project.setup_date.strftime('%d %b %y')}"] = 0
      total_payments["#{x.created_at.strftime('%d %b %y')}"] = total_funds
      @hash_limit["#{x.created_at.strftime('%d %b %y')}"] = project.goal
    end

    @hash_limit["#{project.setup_date.strftime('%d %b %y')}"] = project.goal
    @hash_labels = daily_payments.keys
    @hash_values = daily_payments.values.map(&:to_i)
    @hhash_values = total_payments.values.map(&:to_i)
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
