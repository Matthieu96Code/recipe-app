require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'Test User') }
  let(:food) { Food.create(name: 'Test Food', user_id: user.id) }
  let(:recipe) { Recipe.create(name: 'Test Recipe', preparation_time: 10, cooking_time: 20, user_id: user.id) }

  describe 'validations' do
    it 'requires a user' do
      recipe_food = RecipeFood.new(food_id: food.id, recipe_id: recipe.id)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:user]).to include('must exist')
    end

    it 'requires a food' do
      recipe_food = RecipeFood.new(user_id: user.id, recipe_id: recipe.id)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:food]).to include('must exist')
    end

    it 'requires a recipe' do
      recipe_food = RecipeFood.new(user_id: user.id, food_id: food.id)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:recipe]).to include('must exist')
    end
  end
end
