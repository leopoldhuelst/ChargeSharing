class User < ApplicationRecord
  has_many :plugs, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :bookings_as_owner, through: :plugs, source: :bookings
  has_many :reviews, through: :bookings
  has_many :reviews_as_owner, through: :bookings_as_owner, source: :reviews

  acts_as_favoritor

  validates :first_name, presence: true
  validates :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
