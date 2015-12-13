class ProjectDecorator < Draper::Decorator
  delegate_all

  def percent_funds_raised
    percent = 100 * current_funds / goal
    "#{ percent.round(1) }%"
  end
end