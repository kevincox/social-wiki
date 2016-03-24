class AddSubjectUniqueness < ActiveRecord::Migration
  def change
    remove_index :subjects, :name
    add_index :subjects, :name, unique: true
  end
end
