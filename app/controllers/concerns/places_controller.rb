class PlacesController < ApplicationController
  def index
  end

  def show
    @place = BeerMappingApi.place(session[:city], params[:id])
    if @place.nil?
      redirect_to places_path, notice: "No place found"
    else
      render :show
    end
  end

  def search
    unless params[:city].empty?
      @places = BeerMappingApi.places_in(params[:city])
      session[:city] = params[:city]
      if @places.empty?
        redirect_to places_path, notice: "No locations in #{params[:city]}"
      else
        render :index
      end
    else
      redirect_to places_path, notice: "No city given."
    end
  end
end