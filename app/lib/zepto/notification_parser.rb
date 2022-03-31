class Zepto::NotificationParser
  def self.identify_and_execute(request_body:, request_id:)
    new(request_body, request_id).send(:identify_and_execute)
  end

  private

  attr_reader :request_body, :request_id

  def initialize(request_body, request_id)
    @request_body = request_body
    @request_id = request_id
  end

  def identify_and_execute
    case request_identity
    when :payment_request_approved
      Zepto::NotificationHandler.call(
        Zepto::Notifications::PaymentRequestApproved.new(
          name: parsed_request.dig(:data).first.dig(:metadata, :npp_debtor_name),
          amount: parsed_request.dig(:data).first.dig(:payout, :amount),
          request_id: request_id,
        ),
      )
    else
      raise NotImplementedError, "#{request_identity} is not handled in Zepto::NotificationParser"
    end
  end

  def request_identity
    parsed_request.dig(:event, :type).tr(".", "_").to_sym
  end

  def parsed_request
    @parsed_request ||= JSON.parse(request_body).deep_symbolize_keys
  end
end
