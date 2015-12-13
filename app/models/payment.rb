class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :value, presence: true, numericality: { greater_than: 0, less_than: 2_147_483_647 }
  validates :user, presence: true
  validates :project, presence: true
  validate :project_must_be_active

  after_create :increase_project_funds

  private

  def increase_project_funds
    project.current_funds += value
    project.save
  end

  def project_must_be_active
    errors.add(:project, 'must be active') unless project.active?
  end
end
