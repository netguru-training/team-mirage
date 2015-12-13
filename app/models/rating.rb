class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :project, presence: true
  validates :value, numericality: { only_integer: true, minimum: 1, maximum: 10 }
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