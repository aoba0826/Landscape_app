class CreateScheduleDays < ActiveRecord::Migration[6.1]
  def change
    create_table :schedule_days do |t|
      t.references :user, null: false
      t.references :task, null: false
      t.string :schedule_day, null: false
      
      t.timestamps
    end
  end
end
