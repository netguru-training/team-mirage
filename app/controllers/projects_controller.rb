class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  expose(:active_projects) { Project.active }
  expose(:remaining_projects)  { Project.inactive }
  expose(:projects)
  expose(:project, attributes: :projects_params)
  expose(:comments) { project.comments.sorted_by_date }


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
    daily_payments = Hash.new(0)
    total_payments = Hash.new(0)
    total_funds = 0
    @project_goal = {}
    daily_payments[project.setup_date.strftime('%d %b %y')] = 0
    total_payments[project.setup_date.strftime('%d %b %y')] = 0

    project.payments.order(:created_at).map do |payment|
      daily_payments[payment.created_at.strftime('%d %b %y')] += payment.value
      total_funds += payment.value
      total_payments[payment.created_at.strftime('%d %b %y')] = total_funds
      @project_goal[payment.created_at.strftime('%d %b %y')] = project.goal
    end


    @project_goal[project.setup_date.strftime('%d %b %y')] = project.goal
    @daily_payments_labels = daily_payments.keys
    @daily_payments_values = daily_payments.values.map(&:to_i)
    @total_payments_values = total_payments.values.map(&:to_i)
    @finish_date = project.finish_date.to_s.chomp(" UTC")
  end

  def update
    if project.save
      redirect_to project_path(project), notice: 'Your project has been updated'
    else
      render :edit
    end
  end

  def index
    @finish_date = project.finish_date.to_s.chomp(" UTC")
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
