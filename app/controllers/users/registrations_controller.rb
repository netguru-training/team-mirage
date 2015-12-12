class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    resource.add_role :regular
  end
end
