class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    if full_name and last_name
      full_name + ' ' + last_name
    end
  end
end
