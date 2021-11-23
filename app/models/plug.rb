class Plug < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  geocoded_by :location

  validates :plug_type, presence: true, inclusion: { in: [1, 2] }
  validates :availability, presence: true
  validates :location, presence: true
  validates :fixed_cost_per_15_min, presence: true
  after_validation :geocode
end
