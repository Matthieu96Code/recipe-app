require 'rails_helper'

RSpec.feature 'Recipe index page', type: :feature do
  let!(:user) { create(:user) }
  let!(:recipe1) { create(:recipe, name: 'Pasta', description: 'A delicious pasta dish', user:, public: true) }
  let!(:recipe2) { create(:recipe, name: 'Pizza', description: 'A classic pizza recipe', user:, public: true) }
  let!(:recipe3) { create(:recipe, name: 'Salad', description: 'A healthy salad recipe', user:, public: false) }
  before do
    sign_in user
  end
  scenario 'User can see a list of recipes' do
    # Create some recipes to display on the index page

    # Visit the recipe index page
    visit recipes_path
    # Verify that the page contains the recipe names and descriptions
    expect(page).to have_content(recipe1.name)
    expect(page).to have_content(recipe1.description)
    expect(page).to have_content(recipe2.name)
    expect(page).to have_content(recipe2.description)
  end

  scenario 'User can create a new recipe' do
    # Visit the recipe index page
    visit recipes_path

    # Click the "New recipe" link
    click_link 'New recipe'

    # Fill in the recipe form
    fill_in 'Name', with: 'Pizza'
    fill_in 'Description', with: 'A classic Italian dish'
    fill_in 'Preparation time', with: 2
    fill_in 'Cooking time', with: 1
    click_button 'Create Recipe'

    # Verify that the new recipe was created and is displayed on the index page
    expect(page).to have_content('Pizza')
    expect(page).to have_content('A classic Italian dish')
  end
end

RSpec.feature 'Recipe index page User can delete', type: :feature do
  let!(:user) { create(:user) }
  before do
    sign_in user
  end

  scenario 'User can delete a recipe' do
    # Create a recipe to delete
    create(:recipe, name: 'Burger', description: 'A classic American dish', user:, public: true)

    # Visit the recipe index page
    visit recipes_path
    # Click the "Delete recipe" button
    within('#recipe') do
      click_button 'Delete recipe'
    end
    # Verify that the recipe was deleted and is no longer displayed on the index page
    expect(page).to have_content('Recipe was successfully destroyed.')
    expect(page).not_to have_content('Burger')
    expect(page).not_to have_content('A classic American dish')
  end
end
