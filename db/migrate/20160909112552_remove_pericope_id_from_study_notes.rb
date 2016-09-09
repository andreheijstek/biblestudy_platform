class RemovePericopeIdFromStudyNotes < ActiveRecord::Migration
  def change
    remove_column :study_notes, :pericope_id, :integer
  end
end
