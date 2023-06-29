class AddShoppingTagToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :shopping_tag, :boolean, default: false
  end
end
