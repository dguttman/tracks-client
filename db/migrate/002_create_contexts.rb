class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.integer :remote_id
      t.string :name
      t.integer :position
      t.boolean :hide
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :synced_at
    end
  end

  def self.down
    drop_table :contexts
  end
end
