require 'rails_helper'

describe Recipe, type: :model do
  before :each do
    @user = User.create(name: 'user01', email: 'user01@gmail.com', password: 'password01')
    @recipe = Recipe.create(
      user: @user,
      name: 'Recipe 1',
      preparation_time: 8,
      cooking_time: 23,
      description: 'Description 01'
    )
  end

  it 'Recipe model field should be equal to test recipe' do
    expect(@recipe.name).to eq('Recipe 1')
    expect(@recipe.preparation_time).to eq(8)
    expect(@recipe.cooking_time).to eq(23)
    expect(@recipe.description).to eq('Description 01')
  end
end
