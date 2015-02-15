class BeerMappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.write(city, {places: fetch_places_in(city)}, time_to_idle: 30.seconds, timeToLive: 60.seconds) unless Rails.cache.exist? city
    Rails.cache.fetch(city) { fetch_places_in(city) }

    fetch_places_in(city)
  end

  public
  def self.place (city, id)
    places = fetch_places_in(city)
    places.find {|x| x.id == id}
  end

  private

  def self.fetch_places_in(city)
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end
  def self.url
    #url = "http://beermapping.com/webservice/loccity/#{key}/"
    url = "http://stark-oasis-9187.herokuapp.com/api/"
  end
  def self.key
    "511d669d16427ab7298ea1e1b967fc7a"
  end
end