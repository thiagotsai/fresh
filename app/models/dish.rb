class Dish < ActiveRecord::Base
  belongs_to :business_place
  has_many :items

  validates :name, length: { minimum: 3, maximum: 30 }
  mount_uploader :photo, PhotoUploader

  validates :name, presence: true, uniqueness: { scope: [:business_place] }
  validates :business_place, presence: true
  validates :description, presence: true
  validates :price, presence: true

  def today_items
    self.items.where('start_datetime >= :start AND end_datetime <= :end', start: Date.today, end: Date.today + 1)
  end
end
