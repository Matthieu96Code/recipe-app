require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  describe 'recipe show page' do
    before :each do
      @user = User.create!(name: 'user1', email: 'user01@email.com', password: 'password01')

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(@user)
      @recipe = Recipe.create(
        user: @user, name: 'Recipe 1', 
        preparation_time: 7, cooking_time: 23,
        description: 'Description 01')
      
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'

      visit recipe_path(@recipe)
    end
    it 'Recipe content' do
      expect(page).to have_content('Recipe 1')
      expect(page).to have_content("Preparation time: #{@recipe.preparation_time} min")
      expect(page).to have_content("Cooking time: #{@recipe.cooking_time} min")
    end
    it 'Recipes description' do
      expect(page).to have_content('Description 01')
    end
    it 'click on a toggle btn.' do

      visit recipe_path(@recipe)
      click_button 'Make Public'
      expect(page).to have_content('Make Private')
    end
  end
end