class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :payments
  has_many :projects, foreign_key: :owner_id
  has_many :paid_projects, through: :payments, source: :project

  validates :first_name, presence: true
  validates :last_name, presence: true

  def admin?
    has_role? :admin
  end

  def inactive?
    has_role? :inactive
  end

  def self.find_for_authentication(conditions)
    user = super
    if user
      return nil if user.inactive?
    end
    user
  end
end
