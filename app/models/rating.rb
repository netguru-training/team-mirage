class Rating < ActiveRecord::Base
  MIN = 1
  MAX = 10

  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :project, presence: true
  validates :value, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: MIN,
    less_than_or_equal_to: MAX
  }
  validate :project_must_be_succeeded
  validate :user_must_have_contributed_to_project

  def project_must_be_succeeded
    errors.add(:project, 'can\'t rate projects that did not succeed') unless project.succeed?
  end

  def user_must_have_contributed_to_project
    unless user.paid_projects.include?(project)
      errors.add(:project, 'can\t rate projects that you did not contribute to')
    end
  end
end