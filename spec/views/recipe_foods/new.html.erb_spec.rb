require 'rails_helper'

RSpec.describe 'Recipe Foods page', type: :feature do
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user:) }
  let!(:food1) { create(:food, name: 'Chicken', user:) }
  let!(:food2) { create(:food, name: 'Broccoli', user:) }

  before do
    sign_in user
    visit new_recipe_recipe_food_path(recipe)
  end

  context 'when adding a new recipe food' do
    it 'adds the food to the recipe' do
      within 'form' do
        fill_in 'Quantity', with: 2
        select 'Chicken', from: 'Food'
        click_button 'Add ingredient'
      end

      expect(page).to have_current_path(recipe_path(recipe))
      expect(page).to have_content 'Chicken'
      expect(page).to have_content '2'
    end

    it 'navigates back to the recipe page' do
      click_link 'Back to recipe'
      expect(page).to have_current_path(recipe_path(recipe))
    end
  end
end
