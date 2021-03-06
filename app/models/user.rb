class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}
  validates :password, format: {with: /\d.*[A-Z]|[A-Z].*\d/, message: "has to contain one number and one upper case letter"}
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_secure_password

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by { |r| r.score }.last.beer
  end

  def self.top(n)
    sorted_by_ratingCount_in_desc_order = User.all.sort_by { |b| -(b.ratings.count) }
    sorted_by_ratingCount_in_desc_order.take(3)
  end

end
