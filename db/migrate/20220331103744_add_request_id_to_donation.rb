class AddRequestIdToDonation < ActiveRecord::Migration[6.1]
  def change
    add_column(:donations, :request_id, :uuid, index: true)
  end
end
