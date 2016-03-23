class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name, null: false, index: true
      t.text :desc, null: false

      t.timestamps null: false
    end
  end
end
