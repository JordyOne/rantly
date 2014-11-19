class AddCommentsTable < ActiveRecord::Migration
  create_table :comments do |t|
    t.string :title
    t.text :text
  end
end
