class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :contents, null: false
      t.integer :author, null: false

      t.timestamps null: false
    end
  end
end
