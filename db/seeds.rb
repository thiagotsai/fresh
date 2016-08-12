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
Ingredient.create(name: "Basil")
Ingredient.create(name: "Pasta")
Ingredient.create(name: "Lettuce")

Cuisine.create(name: "Italian")
Cuisine.create(name: "Spanish")
Cuisine.create(name: "Chinese")
Cuisine.create(name: "Contemporary food")
Cuisine.create(name: "Japanese")
Cuisine.create(name: "Tapas")

# b = BusinessPlace.new(address: "Rua Sao Bento 41, Lisboa",
#                      zip_code: "1200",
#                      name: "Bear & Bear",
#                      opening_time: "10am-10pm",
#                      average_cost: "20€ for 2 people",
#                      city: "Lisboa",
#                      country: "PT",
#                      cover_photo: "image/upload/v1470949927/restaurant-alcohol-bar-drinks_of6eqk.jpg",
#                      phone_number: "+351 912 123 123",
#                      description: Faker::Lorem.sentence(3),
#                      cuisine_ids: [])

# b.cuisine = Cuisine.find_by_name("Bar")
# b.save

# b.items.create!(name: "Spring salad with potatoes",
#                    user_id: User.first,
#                    photo: "image/upload/v1470952476/pexels-photo-128388_cgzls9.jpg",
#                    price: "8.00",
#                    description: "This vegetarian salad is simply bursting with the fresh flavours of spring, the perfect meal for a sun soaked day.",
#                    start_datetime: Date.today,
#                    end_datetime: Date.today + 1,
#                    ingredient_ids: [8, 7, 4])

# b.items.create!(name: "Caprese Salad",
#                    user_id: User.first,
#                    photo: "image/upload/v1470952481/food_mxu1xs.jpg",
#                    price: "10.00",
#                    description: "Fresh mozzarella, tomatoes, and basil are a classic combination.",
#                    start_datetime: Date.today,
#                    end_datetime: Date.today + 1,
#                    ingredient_ids: [1, 4, 9])


# b = BusinessPlace.new(address: "10 Rua Padarias",
#                      zip_code: "2710-591",
#                      name: "Lorem Ipsum Restaurant",
#                      opening_time: "10am-10pm",
#                      average_cost: "15€ for 2 people",
#                      city: "Sintra",
#                      country: "PT",
#                      cover_photo: "image/upload/v1470949917/menu-restaurant-vintage-table-large_dofafs.jpg",
#                      phone_number: "+351 999 999 999",
#                      description: Faker::Lorem.sentence(3),
#                      cuisine_ids: [])

# b.cuisine = Cuisine.find_by_name("Italian")
# b.save

# b.items.create!(name: "Spring salad with potatoes",
#                    user_id: User.first,
#                    photo: "image/upload/v1470952476/pexels-photo-128388_cgzls9.jpg",
#                    price: "8.00",
#                    description: "This vegetarian salad is simply bursting with the fresh flavours of spring, the perfect meal for a sun soaked day.",
#                    start_datetime: Date.today,
#                    end_datetime: Date.today + 1,
#                    ingredient_ids: [8, 7, 4])

# b.items.create!(name: "Caprese Salad",
#                    user_id: User.first,
#                    photo: "image/upload/v1470952481/food_mxu1xs.jpg",
#                    price: "10.00",
#                    description: "Fresh mozzarella, tomatoes, and basil are a classic combination.",
#                    start_datetime: Date.today,
#                    end_datetime: Date.today + 1,
#                    ingredient_ids: [1, 4, 9])

