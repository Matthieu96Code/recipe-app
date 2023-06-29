# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# User.destroy_all
# Food.destroy_all

# User seeder
# first_user = User.create(name: 'Mancoba', role: 'user', email: 'mancoba@gmail.com')
# second_user = User.create(name: 'Clement', role: 'admin', email: 'admin@gmail.com')

first_user = User.first
second_user = User.second

p "Created #{User.count} Users"

# Food seeder
food_1 = Food.create(user: first_user, name: 'Apple', measurement_unit: 'grams', price: 5, quantity: 10)
food_2 = Food.create(user: first_user, name: 'Pineapple', measurement_unit: 'grams', price: 1, quantity: 10)
food_3 = Food.create(user: second_user, name: 'Chicken breasts', measurement_unit: 'units', price: 2, quantity: 5)


p "Created #{Food.count} Foods"

