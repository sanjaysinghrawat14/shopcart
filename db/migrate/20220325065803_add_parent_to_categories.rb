class AddParentToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :parent_id, :bigint, null: true, index: true
    add_foreign_key :categories, :categories, column: :parent_id
  end
end
