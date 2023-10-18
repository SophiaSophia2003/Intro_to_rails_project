class Category < ApplicationRecord
  has_and_belongs_to_many :books # many to many
  # has_many :book_categories
  # has_many :books, through: :book_categories
  validates_presence_of   :name
  self.per_page = 2
  WillPaginate.per_page = 2

# We are using this method to show the categories in book pages. ie. index page, show, edit page
  def self.list_categories
    self.select(:name,:id).order("name ASC").map { |b| [b.name,b.id] }
  end

  # not working yet
  def check_for_book
    books = BookCategory.where(category_id: self.id)
    books.destroy_all if books.present?
  end

end