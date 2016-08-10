class BusinessPlace < ActiveRecord::Base
  has_many :cuisines, through: :business_cuisine
  has_many :users, through: :business_place_user
  has_many :menus
  has_many :items, through: :menus
  validates :name, presence: true, uniqueness: { scope: [:address, :city] }
  validates :description, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  mount_uploader :cover_photo, PhotoUploader

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  def full_address
    "#{address}, #{zip_code} #{city} #{ISO3166::Country[country].name}"
  end

  def full_address_changed?
    address_changed? || zip_code_changed? || city_changed? || country_changed?
  end

end

