class BusinessPlace < ActiveRecord::Base
  has_many :cuisines, through: :business_cuisine
  has_many :users, through: :business_place_user
  has_many :menus
  has_many :items, through: :menus
  validates :name, presence: true, uniqueness: { scope: [:address, :city] }
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  mount_uploader :cover_photo, PhotoUploader
end

