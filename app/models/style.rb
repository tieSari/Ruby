class Style < ActiveRecord::Base
  has_many :beers

  def to_s
    name
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.beers.count) }
    sorted_by_rating_in_desc_order.take(3)
  end
end