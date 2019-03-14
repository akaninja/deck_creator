class AddVisibilityToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :visibility, :boolean
  end
end
