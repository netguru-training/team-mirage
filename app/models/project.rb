class Project < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  validates :owner, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :goal, presence: true,
                   numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :current_funds, presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :setup_date, presence: true
  validates :finish_date, presence: true
end
