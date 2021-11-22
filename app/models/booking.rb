class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :plug
  has_many :reviews, dependent: :destroy

  validates :date_time, presence: true
  validates :duration, presence: true
end
