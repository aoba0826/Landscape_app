class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.references :user   ,null: false
      t.string :title      ,null: false
      t.string :place      ,null: false
      t.text :introduction ,null: false
      t.float :star

      t.timestamps
    end
  end
end
