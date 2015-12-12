module ApplicationHelper
  def cents_to_dollars(number)
    number_to_currency(number / 100.00)
  end
end
