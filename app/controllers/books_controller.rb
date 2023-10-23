# app/controllers/books_controller.rb
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.paginate(:page => params[:page], :per_page => 10)
  	@books = Book.joins(:categories).select("books.*,categories.*").where(categories: {id: params[:category]}).paginate(:page => params[:page], :per_page => 10)	if params[:category].present?
    @books = @books.joins(:categories).select("books.*,categories.*").where("title LIKE ?", "%#{params[:search]}%").paginate(:page => params[:page], :per_page => 10) if params[:search].present?
  end

  def show
    @authors = BookAuthor.joins(:author).select("authors.name as author_name, authors.id as a_id").where(book_id: @book.id)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
  	# @categories = BookCategory.joins(:category).select("book_categories.*,categories.name as cat_name, categories.id as c_id").where(book_id: @book.id)
    @authors = BookAuthor.joins(:author).select("book_authors.*,authors.name as author_name, authors.id as a_id").where(book_id: @book.id)
  end

  def update
    if @book.update(book_params)
      author_ids = book_params[:author_id].to_a.reject(&:blank?)
      if author_ids.present?
        author_ids.each_with_index do |a_id, index|
          BookAuthor.create!(author_id: a_id,book_id: @book.id)
        end
      end
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  # def search
  #   byebug
  #   @search = Book.new(search_params)
  #   @results = @search.perform_search
  # end


  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, author_id: [] , category_ids: [])
  end

  # def search_params
  #   params.require(:search).permit(:keyword, :category_id)
  # end  
end
