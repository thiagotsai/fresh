class Item < ActiveRecord::Base
  belongs_to :business_place
  belongs_to :user
  has_many :item_info, dependent: :destroy
  has_many :ingredients, through: :item_info
  validates :name, length: { minimum: 3, maximum: 30 }
  mount_uploader :photo, PhotoUploader
  accepts_nested_attributes_for :ingredients

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
