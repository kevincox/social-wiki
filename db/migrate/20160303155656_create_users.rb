class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username null: false 
      t.string :password null: false
      t.string :email null: false
      t.integer :upVote nullL:false default:0
      t.integer :downVote null:false default:1
      t.timestamps null: false
    end
  end
end
