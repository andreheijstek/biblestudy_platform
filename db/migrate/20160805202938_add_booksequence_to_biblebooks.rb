class AddBooksequenceToBiblebooks < ActiveRecord::Migration[4.2]
  def change
    add_column :biblebooks, :booksequence, :integer
  end
end
