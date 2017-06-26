class AddSequenceToPericopes < ActiveRecord::Migration[4.2]
  def change
    add_column :pericopes, :sequence, :int
  end
end
