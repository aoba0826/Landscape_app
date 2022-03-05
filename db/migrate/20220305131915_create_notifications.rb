class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :post_image,    null: false
      t.references :post_comment,  null: false
      t.integer :visiter_id
      t.integer :visited_id
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
