class AddExpressTokenToOrder2s < ActiveRecord::Migration[7.0]
  def change
    add_column :order2s, :express_token, :string
    add_column :order2s, :express_payer_id, :string
  end
end
