class SeriesRequestsController < ApplicationController
  def new
    @series_request = SeriesRequest.new
  end

  def create
    @series_request = SeriesRequest.new(series_request_params)
    if @series_request.save
      flash[:notice] = "Thank you for your request!"
    else
      flash[:alert] = "There was a problem requesting your series."
    end
    redirect_to new_series_request_path
  end

  def edit
  end

  def update
  end

  def show
  end

  private 
  def series_request_params 
    params.require(:series_request).permit(:series, :author, :email) 
  end

end
