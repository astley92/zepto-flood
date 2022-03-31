class ZeptoController < ApplicationController
  include Zepto::WebhookSignatureConcern

  skip_before_action :verify_authenticity_token
  before_action :validate_received_webhook

  def callback
    Zepto::NotificationParser.identify_and_execute(
      request_body: request.body.read,
      request_id: request.headers.fetch("Split-Request-Id"),
    )
  end
end
