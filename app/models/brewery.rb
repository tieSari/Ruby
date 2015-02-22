class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: :year_cannot_be_in_the_future
  validates :year, numericality: {greater_than_or_equal_to: 1042,
                                  only_integer: true}


  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }


  def year_cannot_be_in_the_future
    if year > Time.now.year
      errors.add(:year, " can't be in the future")
    end
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take(3)
  end

end
