class User < ActiveRecord::Base
  rolify
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :payments
  has_many :projects, foreign_key: :owner_id
  has_many :paid_projects, -> { uniq }, through: :payments, source: :project

  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :cant_be_both_admin_and_inactive

  def cant_be_both_admin_and_inactive
    user_roles = roles.map(&:name)
    if user_roles.include?('admin') && user_roles.include?('inactive')
      errors.add(:roles, "User can't be both admin and inactive")
    end
  end

  %i(admin regular inactive).each do |role|
    define_method("#{role}?") do
      has_role? role
    end
  end

  def made_payment_for?(project_id)
    paid_projects.exists?(id: project_id)
  end

  def self.find_for_authentication(conditions)
    user = super
    if user
      return nil if user.inactive?
    end
    user
  end
end
