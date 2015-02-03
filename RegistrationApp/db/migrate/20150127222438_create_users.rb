class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_digest, null: false
      t.string :email, limit: 254, null: false
      t.timestamps
    end
    
    add_index :users, :email, unique: true
  end
end
