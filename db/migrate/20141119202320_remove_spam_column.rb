class RemoveSpamColumn < ActiveRecord::Migration
  def change
    remove_column :rants, :spam
  end
end
