# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "net/http"
require "json"

# Getting data from Google Books API with multiple requests.
books_requests = [{ query_params: "business", size: 20 },
{ query_params: "health", size: 20 },
{ query_params: "yoga", size: 20 },
{ query_params: "religious", size: 20 },
{ query_params: "computers", size: 20 },
{ query_params: "sports", size: 20 },
{ query_params: "fashion", size: 20 }]
books_requests.each do |request|
  # API call
  url = "https://www.googleapis.com/books/v1/volumes?q=#{request[:query_params]}&maxResults=#{request[:size]}&startIndex=1&printType=books"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  api_response_data = data["items"]

  api_response_data.each do |element|
    title = element["volumeInfo"]["title"]
    description = element["volumeInfo"]["description"]
    lang = element["volumeInfo"]["language"]
    isbn = element["volumeInfo"]["industryIdentifiers"]&.dig(0, "identifier")
    publisher_name = element["volumeInfo"]["publisher"]
    published_date = element["volumeInfo"]["publishedDate"]
    preview_link = element["volumeInfo"]["previewLink"]
    authors = element["volumeInfo"]["authors"]
    categories = element["volumeInfo"]["categories"]

    book_unique_fields = [isbn, authors, categories,publisher_name,published_date, description ]

    # If any of the required filed is null or equal zero then skip this book api response for book
    if book_unique_fields.any? { |attribute| attribute.nil? || attribute == 0 }
      next
    end

    # Validate for duplicate book by ISBN
    book_record = Book.find_by(isbn: isbn)
    if book_record
      next
    end

    # Create record from API response
    book = Book.create(title: title,description: description,isbn: isbn,published_date: published_date, language: lang, image_small_thumbnail: element["volumeInfo"]["imageLinks"]&.dig("smallThumbnail"), image_thumbnail: element["volumeInfo"]["imageLinks"]&.dig("thumbnail"), preview_link: preview_link)

    if categories.present?
      categories.each do |category_name|
        category = Category.find_or_create_by(name: category_name)
        category.books << book
      end
    end
    if authors.present?
      authors.each do |author_name|
        author = Author.find_or_create_by(name: author_name)
        author.save
      end
    end


    publisher_name = element["volumeInfo"]&.dig("publisher")
    # Create Publisher
    publisher = Publisher.find_or_create_by(name: publisher_name)
  end
end


  Book.all.each do |book|
   BookAuthor.create(book_id: book.id,author_id: Author.first.id)
  end


