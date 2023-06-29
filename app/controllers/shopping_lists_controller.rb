class ShoppingListsController < ApplicationController
  def index
    # Get the list of missing food items for all recipes with shopping_tag true
    @recipe_foods = RecipeFood.includes(:food, :recipe)
      .where(recipes: { shopping_tag: true })

    # Calculate the total count and price of missing food items
    @total_missing_count = 0
    @total_missing_price = 0
    @missing_foods = []

    @recipe_foods.each do |recipe_food|
      missing_quantity = recipe_food.quantity - recipe_food.food.quantity

      next unless missing_quantity.positive?

      @missing_foods << recipe_food
      @total_missing_count += 1
      @total_missing_price += missing_quantity * recipe_food.food.price
    end
  end
end
