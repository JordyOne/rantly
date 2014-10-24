class AddRantTable < ActiveRecord::Migration
  create_table :rants do |t|
    t.string :text

  end
end
