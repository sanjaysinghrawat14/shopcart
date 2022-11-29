class ChangeInAddresses < ActiveRecord::Migration[7.0]
  def change
    change_column :addresses, :address, :text, null: true

  end
end
