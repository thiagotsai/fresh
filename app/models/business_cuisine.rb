class BusinessCuisine < ActiveRecord::Base
  belongs_to :business_place
  belongs_to :cuisine
end
