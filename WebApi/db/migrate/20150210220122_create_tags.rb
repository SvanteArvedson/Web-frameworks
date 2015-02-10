class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, limit: 40, null: false
      
      t.timestamps
    end
  end
end
