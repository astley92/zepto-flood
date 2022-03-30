module Zepto::NotificationHandler
  module_function

  def call(message)
    raise NotImplementedError unless message.is_a?(Zepto::Notifications::PaymentRequestApproved)

    # TODO: Should defer this to a background job for processing
    Donation.create!(
      name: message.name,
      amount: message.amount,
    )
  end
end
