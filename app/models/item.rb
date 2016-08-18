class Item < ActiveRecord::Base
  belongs_to :dish
  belongs_to :business_place
  belongs_to :user
  has_many :item_info, dependent: :destroy
  has_many :ingredients, through: :item_info
  validates :name, length: { minimum: 3, maximum: 30 }
  include CopyCarrierwaveFile
  mount_uploader :photo, PhotoUploader
  accepts_nested_attributes_for :ingredients

  validates :dish, presence: true
  validates :business_place, presence: true
  validates :user, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  def duplicate_photo(original)
    copy_carrierwave_file(original, self, :photo)
    self.save!
  end
end
