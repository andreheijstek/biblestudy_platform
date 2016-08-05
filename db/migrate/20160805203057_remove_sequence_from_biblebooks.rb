class RemoveSequenceFromBiblebooks < ActiveRecord::Migration
  def change
    remove_column :biblebooks, :sequence, :integer
  end
end
