class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.integer :remote_todo_id
      t.integer :context_id
      t.datetime :completed_at
      t.integer :recurring_todo_id
      t.datetime :show_from
      t.text :notes
      t.integer :project_id
      t.string :description
      t.datetime :due
      t.string :state
    end
  end

  def self.down
    drop_table :todos
  end
end
