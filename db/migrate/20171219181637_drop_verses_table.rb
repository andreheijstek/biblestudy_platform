class DropVersesTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :verses
  end
end
