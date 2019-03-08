class AddHighlightToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :highlight, :boolean
  end
end
