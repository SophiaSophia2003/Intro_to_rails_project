class Author < ApplicationRecord
  has_and_belongs_to_many :books
  # has_many :book_authors
  # has_many :books, through: :book_authors
  validates_presence_of   :name
end