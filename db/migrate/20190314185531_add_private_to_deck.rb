class AddPrivateToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :private, :boolean
  end
end
