require 'rails_helper'

describe Recipe, type: :model do
  before :each do
    @user = User.create(name: 'user01', email: 'user01@gmail.com', password: 'password01')
    puts @user.errors.full_messages
    @recipe = Recipe.create(
      user: @user, 
      name: 'Recipe 1', 
      preparation_time: 8, 
      cooking_time: 23,
      description: 'Description 01'
    )

    @food = Food.create(user: @user, name: 'Food 1', measurement_unit: 'gram', price: 9.99, quantity: 4)
    @recipe_food = RecipeFood.create(quantity: 8, food: @food, recipe: @recipe)
  end

  it 'RecipeFood model field should be equal to test recipe_food' do
    expect(@recipe_food.quantity).to eq(8)
    expect(@recipe_food.food).to eq(@food)
    expect(@recipe_food.recipe).to eq(@recipe)
  end
end