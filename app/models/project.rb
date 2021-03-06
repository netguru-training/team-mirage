class Project < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :payments
  has_many :comments
  has_many :ratings

  scope :active, -> { where(status: 'active') }
  scope :inactive, -> { where.not(status: 'active') }

  validates :owner_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :goal, presence: true,
                   numericality: { greater_than_or_equal_to: 0 }
  validates :current_funds, presence: true,
                            numericality: { greater_than_or_equal_to: 0 }
  validates :setup_date, presence: true
  validates :finish_date, presence: true
  validate :update_date_validate, on: :update
  validate :date_validate, on: :create
  validate :goal_range

  enum status: [ :active, :succeed, :failed, :waiting ]

  def date_validate
    if setup_date.nil? || finish_date.nil?
      errors.add(:setup_date, "Dates can't be empty")
    else
      if setup_date < Date.today
        errors.add(:setup_date, "Project can't start in the past")
      elsif finish_date < setup_date
        errors.add(:finish_date, "Project can't be finished before its start")
      end
    end
  end

  def update_date_validate
    if finish_date.nil?
      errors.add(:setup_date, "Finish date can't be empty")
    else
      if finish_date < setup_date
        errors.add(:finish_date, "Project can't be finished before its start")
      elsif finish_date < Date.today
        errors.add(:finish_date, "Project can't be finished before today")
      end
    end

  end

  def goal_range
    if goal.nil?
      errors.add(:setup_date, "Goal can't be empty")
    else
      if goal > 2_147_483_647
        errors.add(:goal, "We are sorry but your goal is too big")
      end
    end
  end
end
