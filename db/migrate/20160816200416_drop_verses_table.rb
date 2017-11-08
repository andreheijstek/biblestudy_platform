# frozen_string_literal: true

class DropVersesTable < ActiveRecord::Migration[4.2]
  def up
    drop_table :verses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
