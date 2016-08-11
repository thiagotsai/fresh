class Item < ActiveRecord::Base
  belongs_to :menu
  belongs_to :user
  has_and_belongs_to_many :business_places, through: :menu
  has_many :item_info
  has_many :ingredients, through: :item_info
  mount_uploader :photo, PhotoUploader
  accepts_nested_attributes_for :ingredients
end
