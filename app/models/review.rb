class Review < ApplicationRecord
  belongs_to :booking
  # belongs_to
  # belongs_to

  validates :rating, presence: true
  validates :review_type, presence: true, inclusion: { in: [0, 1] }
end
