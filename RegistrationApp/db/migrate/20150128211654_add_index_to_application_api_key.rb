class AddIndexToApplicationApiKey < ActiveRecord::Migration
  def change
    add_index :applications, :api_key, unique: true
  end
end
