class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :contents
      t.references :post,:user, index: true, foreign_key: true, null: false
      t.timestamps null: false
    end
  end
end
