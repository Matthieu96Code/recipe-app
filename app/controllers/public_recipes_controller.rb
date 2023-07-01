class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.public_recipes.includes(:user, recipe_foods: [:food]).order(created_at: :desc)
  end
end
