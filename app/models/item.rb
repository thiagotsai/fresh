class Item < ActiveRecord::Base
  belongs_to :business_place
  belongs_to :user
  has_many :item_info, dependent: :destroy
  has_many :ingredients, through: :item_info
  mount_uploader :photo, PhotoUploader
  accepts_nested_attributes_for :ingredients
end
