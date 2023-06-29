require 'rails_helper'

RSpec.feature 'Recipe show page', type: :feature do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:, public: false) }

  before do
    sign_in user
    visit recipe_path(recipe)
  end

  scenario 'User can view recipe details' do
    expect(page).to have_content(recipe.name)
    expect(page).to have_content("Preparation time: #{recipe.preparation_time} min")
    expect(page).to have_content("Cooking time: #{recipe.cooking_time} min")
    expect(page).to have_content(recipe.description)
  end

  scenario 'User can toggle recipe privacy' do
    expect(page).to have_content('Make Public')

    click_button 'Make Public'

    expect(page).to have_content('Make Private')
  end

  scenario 'User can toggle recipe shopping tag' do
    expect(page).to have_content('Generate shopping list')

    click_button 'Generate shopping list'

    expect(page).to have_content('Remove shopping list')
  end

  scenario 'User can delete recipe food' do
    recipe_food = create(:recipe_food, recipe:, user:, quantity: 1,
                                       food: create(:food, name: 'milk', user:))
    visit recipe_path(recipe)

    expect(page).to have_content(recipe_food.food.name)
    click_button 'Delete'
    expect(page).not_to have_content(recipe_food.food.name)
  end
end
