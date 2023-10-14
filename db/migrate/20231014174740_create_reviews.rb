class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.datetime :review_date

      t.timestamps
    end
  end
end