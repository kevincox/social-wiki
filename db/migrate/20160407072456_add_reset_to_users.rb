class AddResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_digest, :string, null: false
    add_column :users, :reset_sent_at, :datetime, null: false
  end
end
