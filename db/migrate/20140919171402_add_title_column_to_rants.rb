class AddTitleColumnToRants < ActiveRecord::Migration
  def change
    add_column :rants, :title, :string
  end
end
