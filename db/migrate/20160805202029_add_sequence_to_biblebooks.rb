class AddSequenceToBiblebooks < ActiveRecord::Migration
  def change
    add_column :biblebooks, :sequence, :integer
  end
end
