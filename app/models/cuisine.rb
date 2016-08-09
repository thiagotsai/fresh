class Cuisine < ActiveRecord::Base
  has_many :business_places, through: :business_cuisine
  validates :name, presence: true, uniqueness: true
end
