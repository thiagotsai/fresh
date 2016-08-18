class Dish < ActiveRecord::Base
  belongs_to :business_place
  has_many :items

  validates :name, length: { minimum: 3, maximum: 30 }
  mount_uploader :photo, PhotoUploader

  validates :business_place, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
