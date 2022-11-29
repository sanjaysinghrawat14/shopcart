class CreateUserFeedBacks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_feed_backs do |t|
      t.integer :rating
      t.string :comment
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
