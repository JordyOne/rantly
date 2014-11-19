class AddSpamTable < ActiveRecord::Migration
  def change
    create_table :spams do |t|
      t.integer :user_id
      t.integer :rant_id
    end
  end
end
