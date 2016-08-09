class BusinessPlace < ActiveRecord::Base
  belongs_to :city
  has_many :cuisines, through: :business_cuisine
  has_many :users, through: :business_place_user
  has_many :menus
  has_many :items, through: :menus
  validates :name, presence: true, uniqueness: { scope: :address, :city }
  validates :address, presence: true
  validates :post_code, presence: true
  validates :city, presence: true
  validates :cover_photo, presence: true
  validates :phone_number, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
end

