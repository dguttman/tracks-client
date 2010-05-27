class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.integer :remote_id
      t.integer :remote_context_id
      t.integer :remote_project_id
      t.integer :context_id
      t.integer :project_id
      t.datetime :completed_at
      t.integer :recurring_todo_id
      t.datetime :show_from
      t.text :notes
      t.string :description
      t.datetime :due
      t.string :state
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :todos
  end
end
