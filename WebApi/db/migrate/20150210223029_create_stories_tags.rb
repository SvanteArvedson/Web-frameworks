class CreateStoriesTags < ActiveRecord::Migration
  def change
    create_table :stories_tags, id: false do |t|
      t.integer :story_id
      t.integer :tag_id
    end
    
    add_index :stories_tags, [:story_id, :tag_id]
  end
end
