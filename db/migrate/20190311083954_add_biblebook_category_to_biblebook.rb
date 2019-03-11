class AddBiblebookCategoryToBiblebook < ActiveRecord::Migration[5.2]
  def change
    add_reference :biblebooks, :category, foreign_key: true
  end
end
