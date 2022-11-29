class AddDateEndToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :dat_upto, :datetime
  end
end
