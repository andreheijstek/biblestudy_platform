class AddPericopeRefToStudyNotes < ActiveRecord::Migration
  def change
    add_reference :study_notes, :pericope, index: true, foreign_key: true
  end
end
