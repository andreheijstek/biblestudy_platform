class RemoveOrderFromBiblebooks < ActiveRecord::Migration
  def change
    remove_column :biblebooks, :order, :integer
  end
end
