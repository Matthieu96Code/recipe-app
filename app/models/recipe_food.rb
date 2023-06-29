class RecipeFood < ApplicationRecord
  belongs_to :user
  belongs_to :food
  belongs_to :recipe

  validates :user, presence: true
  validates :food, presence: true
  validates :recipe, presence: true
end
