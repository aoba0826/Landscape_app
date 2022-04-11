class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :user,        null: false
      t.string :title_task,      null: false
      t.string :task_place,      null: false
      t.text :content,           null: false
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
