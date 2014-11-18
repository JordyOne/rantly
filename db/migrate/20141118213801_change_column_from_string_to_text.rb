class ChangeColumnFromStringToText < ActiveRecord::Migration
  def change
    change_column :rants, :text, :text
  end
end
