class RemoveDescriptionFromBiblebooks < ActiveRecord::Migration
  def change
    remove_column :biblebooks, :description, :string
  end
end
