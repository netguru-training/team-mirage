class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ')
  end

  def display_roles
    roles.map(&:name).join(', ')
  end

  def invitation_status
    return "Invitation accepted" if invitation_accepted_at.present?
    return "Invitation pending" if invitation_sent_at.present?
    "Self registered"
  end
end
