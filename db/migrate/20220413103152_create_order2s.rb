class CreateOrder2s < ActiveRecord::Migration[7.0]
  def change
    create_table :order2s do |t|
      t.string :new
      t.integer :cart_id
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.date :card_expires_on

      t.timestamps
    end
  end
end
