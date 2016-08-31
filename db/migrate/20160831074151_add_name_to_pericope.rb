class AddNameToPericope < ActiveRecord::Migration
  def change
    add_column :pericopes, :name, :string
  end
end
