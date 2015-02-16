class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :developer
      t.references :application_type
      
      t.string :name, limit: 100, null: false
      t.string :api_key, null: false
      
      t.timestamps
    end
    
    add_index :applications, :api_key, unique: true
  end
end
