class Rating < ActiveRecord::Base
  MIN = 1
  MAX = 10

  belongs_to :user
  belongs_to :project

  scope :by, -> (user_id) { where(user_id: user_id) }

  validates :user, presence: true
  validates :project, presence: true
  validates :value, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: MIN,
    less_than_or_equal_to: MAX
  }
  validate :project_must_be_succeeded
  validate :user_must_have_contributed_to_project
  validate :same_user_cannot_rate_twice

  def project_must_be_succeeded
    return if project.succeed?
    errors.add(:project, 'can\'t rate projects that did not succeed')
  end

  def user_must_have_contributed_to_project
    return if user.paid_projects.include?(project)
    errors.add(:project, 'can\t rate projects that you did not contribute to')
  end

  def same_user_cannot_rate_twice
    return if project.ratings.by(user).first.nil?
    errors.add(:project, 'can\'t be rated by the same user twice')
  end
end