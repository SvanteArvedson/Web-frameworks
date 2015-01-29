class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :user
      t.references :application_type
      
      t.string :name, limit: 100, null: false
      t.string :api_key, null: false
      
      t.timestamps
    end
  end
end
