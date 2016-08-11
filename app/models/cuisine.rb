class Cuisine < ActiveRecord::Base
  has_many :business_cuisines
  has_and_belongs_to_many :business_places, through: :business_cuisines
  # has_many :business_places, through: :business_cuisine
  validates :name, presence: true, uniqueness: true
end
