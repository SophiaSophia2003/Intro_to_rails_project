class CreateTableBookCovers < ActiveRecord::Migration[7.0]
  def change
    create_table :book_covers do |t|
      t.string :image
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
