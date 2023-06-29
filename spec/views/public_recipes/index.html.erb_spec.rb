require 'rails_helper'

RSpec.describe 'Public Recipes page', type: :feature do
  let(:user) { create(:user, name: 'Test User', email: 'test@example.com', password: 'password') }
  let!(:recipe1) { create(:recipe, name: 'Pasta', description: 'A delicious pasta dish', user:, public: true) }
  let!(:recipe2) { create(:recipe, name: 'Pizza', description: 'A classic pizza recipe', user:, public: true) }
  let!(:recipe3) { create(:recipe, name: 'Salad', description: 'A healthy salad recipe', user:, public: false) }

  describe 'index' do
    before do
      sign_in user
      visit public_recipes_path
    end

    it 'displays the page title' do
      expect(page).to have_content 'Public Recipes'
    end

    it 'displays a list of public recipes' do
      expect(page).to have_content 'Pasta'
      expect(page).to have_content 'By: Test User'
      expect(page).to have_content 'Total food items:'
      expect(page).to have_content 'Total price:'

      expect(page).to have_content 'Pizza'
      expect(page).to have_content 'By: Test User'
      expect(page).to have_content 'Total food items:'
      expect(page).to have_content 'Total price:'

      expect(page).not_to have_content 'Salad'
    end

    it 'links to individual recipe pages' do
      click_link 'Pasta'
      expect(page).to have_content 'Pasta'
      expect(page).to have_content 'A delicious pasta dish'
      expect(page).to have_content 'Cooking time: 1 mins'
    end
  end
end
