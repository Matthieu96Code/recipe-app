require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    it 'is valid with a name, preparation time, cooking time, and user_id' do
      recipe = Recipe.new(name: 'Test Recipe', preparation_time: 10, cooking_time: 20, user_id: user.id)
      expect(recipe).to be_valid
    end

    it 'is invalid without a name' do
      recipe = Recipe.new(name: nil, preparation_time: 10, cooking_time: 20, user_id: user.id)
      expect(recipe).to_not be_valid
      expect(recipe.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a negative preparation time' do
      recipe = Recipe.new(name: 'Test Recipe', preparation_time: -10, cooking_time: 20, user_id: user.id)
      expect(recipe).to_not be_valid
      expect(recipe.errors[:preparation_time]).to include('must be greater than or equal to 0')
    end

    it 'is invalid with a negative cooking time' do
      recipe = Recipe.new(name: 'Test Recipe', preparation_time: 10, cooking_time: -20, user_id: user.id)
      expect(recipe).to_not be_valid
      expect(recipe.errors[:cooking_time]).to include('must be greater than or equal to 0')
    end

    it 'is invalid without a user_id' do
      recipe = Recipe.new(name: 'Test Recipe', preparation_time: 10, cooking_time: 20, user_id: nil)
      expect(recipe).to_not be_valid
      expect(recipe.errors[:user_id]).to include("can't be blank")
    end
  end

  describe '#toggle_privacy!' do
    it 'toggles the privacy attribute of the recipe' do
      user = User.create(name: 'Test User')
      recipe = Recipe.new(name: 'Test Recipe', preparation_time: 10, cooking_time: 20, public: true, user_id: user.id)

      recipe.toggle_privacy!

      expect(recipe.public).to eq(false)

      recipe.toggle_privacy!

      expect(recipe.public).to eq(true)
    end
  end

  describe 'scopes' do
    describe '.public_recipes' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:public_recipe) { FactoryBot.create(:recipe, public: true, user:) }
      let!(:private_recipe) { FactoryBot.create(:recipe, public: false, user:) }

      it 'returns only public recipes' do
        expect(Recipe.public_recipes).to eq([public_recipe])
      end

      it 'orders recipes by created_at in descending order' do
        expect(Recipe.public_recipes.to_sql).to match(/ORDER BY "recipes"."created_at" DESC/i)
      end
    end
  end
end
