class AuthorsController < ApplicationController
	before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @books = Book.joins(:authors).select("books.*").where(authors: {id: params[:id]}).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to @author, notice: 'Author was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @author.update(author_params)
      redirect_to @author, notice: 'Author was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    books = Book.where(author_id: @author.id)
    books.delete_all if books.present?
    @author.destroy
    redirect_to authors_url, notice: 'Author was successfully destroyed.'
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
