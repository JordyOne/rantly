class AddUserIdandRantIdtoCommentTable < ActiveRecord::Migration
  def change
    add_column :comments, :rant_id, :integer
    add_column :comments, :user_id, :integer
  end
end
