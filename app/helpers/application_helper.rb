module ApplicationHelper
  def formatted_money(cents:)
    number_to_currency(cents / 100.0)
  end
end
