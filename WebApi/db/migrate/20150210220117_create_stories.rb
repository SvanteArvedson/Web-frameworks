class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.references :creator
      t.references :position
      
      t.string :name, limit: 50, null: false
      t.text :description, null: false
      
      t.timestamps
    end
  end
end
