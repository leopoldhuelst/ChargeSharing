class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :plug
  has_many :reviews, dependent: :destroy
end
