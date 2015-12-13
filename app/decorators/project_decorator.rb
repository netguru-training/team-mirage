class ProjectDecorator < Draper::Decorator
  delegate_all

  def percent_funds_raised
    percent = 100 * current_funds / goal
    "#{ percent.round(1) }%"
  end

  def mean_rating
    mean_rating = ratings.empty? ? 0 : ratings.pluck(:value).sum / ratings.length.to_f
    mean_rating.round(1)
  end
end