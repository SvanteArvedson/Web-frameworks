class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :email, limit: 254, null: false
      t.string :password_digest, null: false
      
      t.timestamps
    end
    
    add_index :creators, :email, unique: true
  end
end
