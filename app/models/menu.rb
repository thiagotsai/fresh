class Menu < ActiveRecord::Base
  belongs_to :business_place
  has_many :items
end
