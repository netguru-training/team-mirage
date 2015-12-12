class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ')
  end
end
