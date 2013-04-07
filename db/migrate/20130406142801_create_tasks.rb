class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :duration
      t.belongs_to :project
      t.belongs_to :resource

      t.timestamps
    end

    create_table :task_dependencies do |t|
      t.integer :successor_id
      t.integer :predecessor_id

      t.timestamps
    end
  end
end
