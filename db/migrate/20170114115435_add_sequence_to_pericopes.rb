class AddSequenceToPericopes < ActiveRecord::Migration
  def change
    add_column :pericopes, :sequence, :int
  end
end
