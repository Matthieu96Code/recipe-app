# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users
User.create(name: "John", role: "admin")
User.create(name: "Jane", role: "user")

# Foods
Food.create(name: "Apples", measurement_unit: "kg", price: 5, quantity: 10, user_id: 1)
Food.create(name: "Chicken", measurement_unit: "lb", price: 8, quantity: 5, user_id: 2)

# Recipes
Recipe.create(name: "Apple Pie", preparation_time: 20, cooking_time: 40, description: "A delicious homemade apple pie recipe.", public: true, user_id: 1)
Recipe.create(name: "Grilled Chicken", preparation_time: 10, cooking_time: 20, description: "A quick and easy grilled chicken recipe.", public: false, user_id: 2)

# RecipeFoods
RecipeFood.create(quantity: 2, user_id: 1, food_id: 1)
RecipeFood.create(quantity: 1, user_id: 2, food_id: 2)
