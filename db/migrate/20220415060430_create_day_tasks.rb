class CreateDayTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :day_tasks do |t|
      t.references :user, null: false
      t.references :schedule_day, null: false
      t.string :task_contents ,null: false
      t.datetime :start_time,null: false
      t.datetime :end_time,null: false
      t.timestamps
    end
  end
end
