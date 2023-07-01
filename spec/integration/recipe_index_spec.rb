require 'rails_helper'

RSpec.describe 'Recipe index', type: :feature do
  before :each do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    visit new_user_session_path
    fill_in 'Email', with: 'test2@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit recipes_path
  end

  it 'Displays the title of the Recipe page' do
    expect(page).to have_content('Recipes')
  end

  it 'Displays a button to add new recipe' do
    expect(page).to have_content('New recipe')
  end
end