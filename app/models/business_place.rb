class BusinessPlace < ActiveRecord::Base
  has_many :business_cuisines
  has_many :cuisines, through: :business_cuisines
  has_many :business_place_users
  has_many :users, through: :business_place_users
  has_many :menus
  has_many :items, through: :menus
  validates :name, presence: true, uniqueness: { scope: [:address, :city] }
  validates :description, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true
  # validates :latitude, presence: true
  # validates :longitude, presence: true
  mount_uploader :cover_photo, PhotoUploader
  accepts_nested_attributes_for :cuisines

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?
  after_create :create_business_place_user, :create_business_place_cuisine

  attr_accessor :current_user
  attr_accessor :cuisine

  def full_address
    "#{address}, #{zip_code} #{city} #{ISO3166::Country[country].name}"
  end

  def full_address_changed?
    address_changed? || zip_code_changed? || city_changed? || country_changed?
  end

  def create_business_place_user
    bpu = BusinessPlaceUser.new(business_place: self, user: current_user, main: true)
    if BusinessPlaceUser.where(business_place: self).empty?
      bpu.main = false
    end
    bpu.save
  end


  def create_business_place_cuisine
    bpc = BusinessCuisine.new(business_place: self, cuisine: cuisine, main: true)
    if BusinessCuisine.where(business_place: self).empty?
      bpc.main = false
    end
    bpc.save
  end

  def owner
    bpu = BusinessPlaceUser.where(business_place: self, main: true).first
    return bpu.user unless bpu.nil?
    return nil
  end

  # def cuisine
  #   bpc = BusinessCuisine.where(business_place: self, main: true).first
  #   return bpc.cuisine unless bpc.nil?
  #   return nil
  # end
end

