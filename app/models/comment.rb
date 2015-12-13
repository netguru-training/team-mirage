class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :project, presence: true
  validates :body, presence: true, length: { minimum: 2 }
end