# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(name: "Customer", description: Faker::Lorem.sentence(3))
Role.create(name: "Restaurant Owner", description: Faker::Lorem.sentence(3))
Role.create(name: "Bakery Owner", description: Faker::Lorem.sentence(3))
Role.create(name: "Restaurant Employee", description: Faker::Lorem.sentence(3))
Role.create(name: "Bakery Employee", description: Faker::Lorem.sentence(3))

Ingredient.create(name: "Cheese")
Ingredient.create(name: "Chocolate")
Ingredient.create(name: "Rice")
Ingredient.create(name: "Tomatoes")
Ingredient.create(name: "Pepper")
Ingredient.create(name: "Chicken")
Ingredient.create(name: "Onion")
Ingredient.create(name: "Potatoes")

Cuisine.create(name: "Italian")
Cuisine.create(name: "Spanish")
Cuisine.create(name: "Chinese")
Cuisine.create(name: "Contemporary food")
Cuisine.create(name: "Japanese")
Cuisine.create(name: "Bar")

b = BusinessPlace.new(address: "Rua Sao Bento 41, Lisboa",
                     zip_code: "1200",
                     name: "Bear & Bear",
                     opening_time: "10am-10pm",
                     average_cost: "20€ for 2 people",
                     city: "Lisboa",
                     country: "PT",
                     cover_photo: "image/upload/v1470949927/restaurant-alcohol-bar-drinks_of6eqk.jpg",
                     phone_number: "+351 912 123 123",
                     description: Faker::Lorem.sentence(3),
                     cuisine_ids: [])

b.cuisine = Cuisine.find_by_name("Bar")
b.save

m = b.menus.create(name: "Daily specials", start_datetime: Date.today, end_datetime: Date.today + 1)
i = m.items.create(name: "Spring salad with potatoes",
                user_id: User.first,
                photo: "image/upload/v1470952476/pexels-photo-128388_cgzls9.jpg",
                price: "8.00",
                description: "This vegetarian salad is simply bursting with the fresh flavours of spring, the perfect meal for a sun soaked day.",
                ingredient_ids: [8, 7, 4])





