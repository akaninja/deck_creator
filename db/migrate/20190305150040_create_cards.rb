class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :play_cost
      t.text :description
      t.references :card_type, foreign_key: true
      t.references :faction, foreign_key: true

      t.timestamps
    end
  end
end
