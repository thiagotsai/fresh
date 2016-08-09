class BusinessPlaceUser < ActiveRecord::Base
  belongs_to :business_place
  belongs_to :user
end
