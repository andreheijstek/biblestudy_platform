class RemoveDescriptionFromBiblebooks < ActiveRecord::Migration[4.2]
  def change
    remove_column :biblebooks, :description, :string
  end
end
