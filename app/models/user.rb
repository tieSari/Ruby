class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4}
  validates :password, format: { with: /[A-Z]+[0-9]/,
                                    message: "at least one big letter and one number" }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships,  dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_secure_password
end
