class Project < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :payments

  validate :date_validate?
  validate :goal_range
  validates :owner_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :goal, presence: true,
                   numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :current_funds, presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :setup_date, presence: true
  validates :finish_date, presence: true

  enum status: [ :active, :succeed, :failed, :waiting ]

  def date_validate?
    if setup_date < Date.today
      errors.add(:setup_date, "Project can't start in the past")
    elsif finish_date < setup_date
      errors.add(:finish_date, "Project can't be finished before its start")
    end
  end

  def goal_range
    if goal > 2147483647
      errors.add(:goal, "We are sorry but your goal is to big")
    end
  end
end
