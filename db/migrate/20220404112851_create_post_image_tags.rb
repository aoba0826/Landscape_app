class CreatePostImageTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_image_tags do |t|
       t.references :post_image
       t.references :tag

      t.timestamps
    end
  end
end
