class User < ActiveRecord::Base
  rolify
  has_many :payments
  has_many :projects, foreign_key: :owner_id
  has_many :paid_projects, through: :payments, source: :project
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def admin?
    has_role? :admin
  end
end
