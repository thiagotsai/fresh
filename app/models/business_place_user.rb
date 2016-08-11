class BusinessPlaceUser < ActiveRecord::Base
  belongs_to :business_place
  belongs_to :user

  validates :business_place, presence: true, uniqueness: { scope: :user }
end
