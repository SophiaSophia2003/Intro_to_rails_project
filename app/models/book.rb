class Book < ApplicationRecord
  has_and_belongs_to_many :authors, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title,:isbn, presence: true
  validates_uniqueness_of :isbn
  self.per_page = 10
  WillPaginate.per_page = 10
end