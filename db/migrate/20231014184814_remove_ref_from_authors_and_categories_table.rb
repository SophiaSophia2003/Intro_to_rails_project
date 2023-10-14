class RemoveRefFromAuthorsAndCategoriesTable < ActiveRecord::Migration[7.0]
  def change
    remove_reference :books, :author, null: false, foreign_key: true
    remove_reference :books, :category, null: false, foreign_key: true
  end
end
