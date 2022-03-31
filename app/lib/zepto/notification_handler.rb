module Zepto::NotificationHandler
  extend ApplicationHelper
  module_function

  def call(message)
    raise NotImplementedError unless message.is_a?(Zepto::Notifications::PaymentRequestApproved)

    # TODO: Should defer this to a background job for processing
    Donation.create!(
      name: message.name,
      amount: message.amount,
      request_id: message.request_id,
    )

    total_amount_html = ApplicationController.render(
      partial: 'pages/total_amount', locals: {donation_total: Donation.sum(:amount)}
    )
    latest_donations_html = ApplicationController.render(
      partial: 'pages/latest_donations', locals: {donations: Donation.order(created_at: :desc).first(5)}
    )

    ActionCable.server.broadcast(
      "donations_channel",
      {
        total_amount_html: total_amount_html,
        latest_donations_html: latest_donations_html,
      }
    )
  end
end
