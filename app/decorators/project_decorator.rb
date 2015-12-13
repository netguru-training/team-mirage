class ProjectDecorator < Draper::Decorator
  delegate_all

  def percent_funds_raised
    percent = 100 * current_funds / goal
    "#{ percent.round(1) }%"
  end

  def mean_rating
    ratings_sum = ratings.inject(0) { |sum, rating| sum += rating.value }
    mean_rating = ratings_sum / ratings.length.to_f
    mean_rating.round(1)
  end
end