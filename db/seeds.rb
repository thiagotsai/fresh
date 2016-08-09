# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
3.times do
  Cuisine.create(name: Faker::Address.country , description: Faker::Lorem.sentence(3))
end

Role.create(name: "Customer", description: Faker::Lorem.sentence(3))
Role.create(name: "Restaurant Owner", description: Faker::Lorem.sentence(3))
Role.create(name: "Bakery Owner", description: Faker::Lorem.sentence(3))
Role.create(name: "Restaurant Employee", description: Faker::Lorem.sentence(3))
Role.create(name: "Bakery Employee", description: Faker::Lorem.sentence(3))

Ingredient.create(name: "Wheat flour")
Ingredient.create(name: "Chocolate")
Ingredient.create(name: "Rice")

3.times do
  c = Country.create(name: Faker::Address.country)
  3.times do
    s = State.create(name: Faker::Address.state, country: c)
    3.times do
      City.create(name: Faker::Address.city, state: s)
    end
  end
end

BusinessPlace.create(address: Faker::Address.street_name, city: City.first,
                     post_code: Faker::Address.postcode, name: Faker::App.name,
                     opening_time: "10am-10pm" , cover_photo: Faker::Company.logo,
                     average_cost: Faker::Commerce.price,
                     lat: Faker::Address.latitude, lon: Faker::Address.longitude)
