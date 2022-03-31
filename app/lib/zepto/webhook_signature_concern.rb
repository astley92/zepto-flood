module Zepto::WebhookSignatureConcern
  def validate_received_webhook
    return if valid_signature && !duplicate_request

    head :bad_request
  end

  private

  def valid_signature
    timestamp, given_signature = request.headers.fetch("Split-Signature").split(".")
    given_signature == expected_signature(timestamp)
  end

  def duplicate_request
    request_id = request.headers.fetch("Split-Request-Id")
    Donation.where(request_id: request_id).any?
  end

  def expected_signature(timestamp)
    signed_payload = [timestamp, request.body.read].join(".")
    # TODO: ENV var for this
    secret = "cc07122c892b7b441a9fde581797771b4fcc7f0d61524f33eaea1a1b55d0e2e3"
    OpenSSL::HMAC.hexdigest('sha256', secret, signed_payload)
  end
end
