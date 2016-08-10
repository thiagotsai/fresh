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

BusinessPlace.create(address: Faker::Address.street_name,
                     zip_code: Faker::Address.zip_code, name: Faker::App.name,
                     opening_time: "10am-10pm", average_cost: Faker::Commerce.price,
                     lat: Faker::Address.latitude, lng: Faker::Address.longitude,
                     city: Faker::Address.city, country: Faker::Address.country,
                     phone_number: Faker::PhoneNumber.phone_number,
                     description: Faker::Lorem.sentence(3))
