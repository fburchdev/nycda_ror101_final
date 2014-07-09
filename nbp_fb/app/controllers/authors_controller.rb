class AuthorsController < ApplicationController
  def index
  	@authors = Author.order(:last_name, :first_name, :middle_name, :prefix, :suffix)
  end

  def show
  	@author = Author.find(params[:id])
  end
end
