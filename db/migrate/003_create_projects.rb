class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :remote_project_id
      t.integer :position
      t.string :name
      t.integer :default_context_id
      t.string :description
      t.string :state
    end
  end

  def self.down
    drop_table :projects
  end
end
