#lisätty kakutus toppien hakuun viikko7 esimerkin mukaan
#haetaan myös kerralla kaikki sivuilla tarvittavat luokat kannasta

class RatingsController < ApplicationController
	  before_action :ensure_that_signed_in, except: [:index, :show]
	  before_action :skip_if_cached, only:[:index]


  def skip_if_cached
    return render :index if fragment_exist?( 'ratingslist' )
  end

	def index
		@ratings = Rating.includes(:users,:beers, :breweries, :styles).all

	@recent = Rating.recent

	#@top_breweries = Brewery.top 3
	#@top_beers = Beer.top 3
	#@top_users = User.top 3
	#@top_styles = Style.top 3

	cache = ActiveSupport::Cache::MemoryStore.new(expires_in: 3.minute)

	    if not cache.exist?"beertop3"
	    cache.write("beertop3", Beer.top(3))
	    end
        @top_beers = cache.read "beertop3"


           if not cache.exist?"brewery top 3"
            cache.write("brewery top 3", Brewery.top(3))
            end
            @top_breweries = cache.read "brewery top 3"

                if not Rails.cache.exist?"user top 3"
                cache.write("user top 3", User.top(3))
                end
                @top_users = cache.read "user top 3"

                     if not Rails.cache.exist?"style top 3"
                     cache.write("style top 3", Style.top(3))
					end
                    @top_styles = cache.read "style top 3"

 	end

	def new
   		@rating = Rating.new
		@beers = Beer.all
	end

	def create
	expire_fragment('ratingslist')
		@rating = Rating.new params.require(:rating).permit(:score, :beer_id)

		if current_user.nil?
		    redirect_to signin_path, notice:'you should be signed in'
		elsif @rating.save
		  current_user.ratings << @rating
		  redirect_to user_path current_user
		else
		  @beers = Beer.all
		  render :new
		end
	end

  	def destroy
  	expire_fragment('ratingslist')
  		rating = Rating.find(params[:id])
    	rating.delete if current_user == rating.user
   	 	redirect_to :back
  	end
end