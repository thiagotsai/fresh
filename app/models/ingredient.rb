class Ingredient < ActiveRecord::Base
  has_many :item_info
  has_and_belongs_to_many :items, through: :item_info
  validates :name, presence: true, uniqueness: true
end
