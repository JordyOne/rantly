class CreateFavoritesTable < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :rant_id

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :rant_id
    add_index :favorites, [:user_id, :rant_id], unique: true
  end
end
