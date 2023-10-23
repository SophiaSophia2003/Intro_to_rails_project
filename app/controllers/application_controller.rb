class ApplicationController < ActionController::Base
	@book_categories = Category.all

  def search
  	byebug
    @search = Book.new(search_params)
    @results = @search.perform_search
  end



  private
  def search_params
    params.require(:search).permit(:keyword, :category_id)
  end  
end
