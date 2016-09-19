class ChangeStudyNoteIdToStudynoteId < ActiveRecord::Migration
  def change
    rename_column :pericopes, :study_note_id, :studynote_id
  end
end
