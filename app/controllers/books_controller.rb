# app/controllers/books_controller.rb
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
  	if params[:category_id].present?
  	  @books = Book.where(category_id: params[:category_id]).paginate(:page => params[:page], :per_page => 10)	

  	  respond_to do |format|
        format.json { render json: @books }
      end
    else
      @books = Book.paginate(:page => params[:page], :per_page => 10)
  	end
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
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, :author_id , category_ids: [])
  end
end
