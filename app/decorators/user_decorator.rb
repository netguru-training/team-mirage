class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ')
  end

  def display_roles
    roles.each.map { |role| role.name }.join(' ')
  end
end
