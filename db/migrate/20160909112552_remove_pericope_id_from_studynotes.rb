class RemovePericopeIdFromStudynotes < ActiveRecord::Migration
  def change
    remove_column :studynotes, :pericope_id, :integer
  end
end
