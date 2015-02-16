class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name, limit: 50, null: false
      t.string :email, limit: 254, null: false
      t.string :password_digest, null: false
      t.boolean :admin, null: false, default: false
      t.timestamps
    end
    
    add_index :developers, :name, unique: true
    add_index :developers, :email, unique: true
  end
end
