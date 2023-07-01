require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  describe 'Recipe' do
    before do
      @user = User.create!(name: 'user1', email: 'user01@email.com', password: 'password01')
      @recipe = Recipe.create!(
        user_id: @user.id, name: 'Recipe 1', 
        preparation_time: 20, cooking_time: 40,
        description: 'Recipe description', public: true)

      @recipe = Recipe.create!(user_id: @user.id, name: 'New private recipe', 
        preparation_time: 20, cooking_time: 40,
        description: 'Recipe description', public: false)

      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'

      visit public_recipes_path
    end

    scenario 'Recipe 1 is displayed on public_recipes page' do
      expect(page).to have_content('Recipe 1')
    end

    scenario 'Recipe 2 is not displayed on public_recipes page' do
      expect(page).should have_no_content('Recipe 2')
    end
  end
end