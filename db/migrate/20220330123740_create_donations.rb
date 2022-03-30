class CreateDonations < ActiveRecord::Migration[6.1]
  def change
    create_table :donations do |t|
      t.string :name, null: false
      t.bigint :amount, null: false

      t.timestamps
    end
  end
end
