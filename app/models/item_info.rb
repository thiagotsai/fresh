class ItemInfo < ActiveRecord::Base
  belongs_to :item
  belongs_to :ingredient
end
