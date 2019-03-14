class AddBiblebookReferenceToBiblebookCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :biblebook_categories, :biblebook, foreign_key: true
  end
end
