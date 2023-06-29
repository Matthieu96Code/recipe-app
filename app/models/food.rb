class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, :measurement_unit, :user_id, presence: true
  validates :price, :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
