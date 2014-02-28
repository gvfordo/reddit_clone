class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :url, null: false, limit: 1024
      t.text :link_text

      t.timestamps
    end
    add_index :links, :user_id
  end
end
