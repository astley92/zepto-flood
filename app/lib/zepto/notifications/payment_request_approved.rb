class Zepto::Notifications::PaymentRequestApproved < Dry::Struct
  attribute :name, Types::Strict::String
  attribute :amount, Types::Strict::Integer
  attribute :request_id, Types::Strict::String
end
