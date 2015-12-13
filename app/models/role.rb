class Role < ActiveRecord::Base
  AVAILABLE_ROLES = %w(regular admin inactive)

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  validates :name, inclusion: { in: AVAILABLE_ROLES }

  scopify
end
