class DropVersesTable < ActiveRecord::Migration
  def up
    drop_table :verses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
