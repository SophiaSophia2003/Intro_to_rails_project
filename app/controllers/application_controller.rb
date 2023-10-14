class ApplicationController < ActionController::Base
	@book_categories = Category.all
end
