require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    it 'is valid with a name, preparation time, cooking time, and user_id' do
      food = Food.new(name: 'Apple Test', measurement_unit: 'grams', price: 10, quantity: 50, user_id: user.id)
      expect(food).to be_valid
    end

    it 'is invalid without a name' do
      food = Food.new(name: nil, measurement_unit: 'grams', price: 10, quantity: 50, user_id: user.id)
      expect(food).to_not be_valid
      expect(food.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without measurement_unit' do
      food = Food.new(name: 'Apple Test', measurement_unit: nil, price: 10, quantity: 50, user_id: user.id)
      expect(food).to_not be_valid
      expect(food.errors[:measurement_unit]).to include("can't be blank")
    end

    it 'is invalid with a negative price' do
      food = Food.new(name: 'Apple Test', measurement_unit: 'grams', price: -10, quantity: 40, user_id: user.id)
      expect(food).to_not be_valid
      expect(food.errors[:price]).to include('must be greater than or equal to 0')
    end

    it 'is invalid with a negative quantity' do
      food = Food.new(name: 'Apple Test', measurement_unit: 'grams', price: 10, quantity: -40, user_id: user.id)
      expect(food).to_not be_valid
      expect(food.errors[:quantity]).to include('must be greater than or equal to 0')
    end

    it 'is invalid without a user_id' do
      food = Food.new(name: 'Apple Test', measurement_unit: 'grams', price: 10, quantity: 30, user_id: nil)
      expect(food).to_not be_valid
      expect(food.errors[:user_id]).to include("can't be blank")
    end
  end
end
