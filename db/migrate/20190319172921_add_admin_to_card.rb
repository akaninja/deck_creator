class AddAdminToCard < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :admin, foreign_key: true
  end
end
