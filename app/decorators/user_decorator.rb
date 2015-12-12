class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    if first_name and last_name
      first_name + ' ' + last_name
    end
  end
end
