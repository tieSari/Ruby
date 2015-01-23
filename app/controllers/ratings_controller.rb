class RatingsController < ApplicationController
  def index
  @ratings=Rating.all
  @beers = Beer.all
  end
  def new
      @rating = Rating.new
    end
    def create
Rating.create params.require(:rating).permit(:score, :beer_id)
redirect_to ratings_path
      end
        def destroy
          rating = Rating.find(params[:id])
          rating.delete
          redirect_to ratings_path
        end
end