class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.references :creator
      
      t.string :name, limit: 50, null: false
      t.text :description, null: false
      
      t.float :latitude, null: false
      t.float :longitude, null: false
      
      t.timestamps
    end
  end
end
