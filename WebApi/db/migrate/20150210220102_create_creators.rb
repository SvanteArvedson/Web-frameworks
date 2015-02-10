class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :name, limit: 50, null: false
      t.string :email, limit: 254, null: true
      t.string :password_digest, null: false
      
      t.timestamps
    end
    
    add_index :creators, :name, unique: true
    add_index :creators, :email, unique: true
  end
end
