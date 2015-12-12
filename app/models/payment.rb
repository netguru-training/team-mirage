class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project


  validates :value, presence: true
  validates :user, presence: true
  validates :project, presence: true
end
