class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ')
  end

  def display_roles
    roles.map(&:name).join(', ')
  end
end
