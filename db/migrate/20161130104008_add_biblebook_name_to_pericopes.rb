class AddBiblebookNameToPericopes < ActiveRecord::Migration
  def change
    add_column :pericopes, :biblebook_name, :string
  end
end
