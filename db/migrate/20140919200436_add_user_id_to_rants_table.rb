class AddUserIdToRantsTable < ActiveRecord::Migration
  def change
    add_column :rants, :user_id, :integer
  end
end
