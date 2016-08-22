class BusinessPlace < ActiveRecord::Base
  has_many :business_cuisines, dependent: :destroy
  belongs_to :cuisine
  has_many :cuisines, through: :business_cuisines
  has_many :business_place_users, dependent: :destroy
  has_many :users, through: :business_place_users
  has_many :dishes, dependent: :destroy
  has_many :items, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: [:address, :city] }
  validates :description, presence: true, length: { maximum: 40 }
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :phone_number, presence: true
  validates :cuisine, presence: true
  # validates :latitude, presence: true
  # validates :longitude, presence: true
  mount_uploader :cover_photo, PhotoUploader
  accepts_nested_attributes_for :cuisines

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?
  after_create :create_business_place_user

  attr_accessor :current_user

  def full_address
    "#{address}, #{zip_code} #{city} #{ISO3166::Country[country].name}"
  end

  def full_address_changed?
    address_changed? || zip_code_changed? || city_changed? || country_changed?
  end

  def create_business_place_user
    bpu = BusinessPlaceUser.new(business_place: self, user: current_user, main: true)
    bpu.save
  end

  def owner
    bpu = BusinessPlaceUser.where(business_place: self, main: true).first
    return bpu.user unless bpu.nil?
    return nil
  end

  def today_items
    self.items.where('start_datetime >= :start AND end_datetime <= :end', start: Date.today, end: Date.today + 1)
  end
end

