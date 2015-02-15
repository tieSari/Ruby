class Beer < ActiveRecord::Base
  include RatingAverage
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, length: {allow_blank: false}

  def to_s
    " #{name} #{Brewery.find_by_id(brewery_id).name} "
  end
end
