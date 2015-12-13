class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :project, presence: true
  validates :value, numericality: { only_integer: true, minimum: 1, maximum: 10 }
  validate :project_must_be_succeeded

  def project_must_be_succeeded
    errors.add(:project, 'can\'t rate projects that did not succeed') unless project.succeed?
  end
end