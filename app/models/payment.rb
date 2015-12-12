class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project


  validate :value, presence: true
end
