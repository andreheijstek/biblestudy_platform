class AddBooksequenceToBiblebooks < ActiveRecord::Migration
  def change
    add_column :biblebooks, :booksequence, :integer
  end
end
