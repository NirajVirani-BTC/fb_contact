class Review < ActiveRecord::Base
  attr_accessible :comment, :place_id, :rating
  validates :comment, :place_id, :rating, presence: true
  belongs_to :place
end
