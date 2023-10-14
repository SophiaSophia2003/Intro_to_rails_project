class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :published_date
      t.text :description
      t.string :isbn
      t.string :language
      t.string :image_small_thumbnail
      t.string :image_thumbnail
      t.string :preview_link

      t.timestamps
    end
  end
end