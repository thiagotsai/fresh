class BusinessCuisine < ActiveRecord::Base
  belongs_to :business_place
  belongs_to :cuisine

  validates :business_place, presence: true, uniqueness: { scope: :cuisine }
end
