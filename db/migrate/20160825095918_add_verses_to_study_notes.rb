class AddVersesToStudyNotes < ActiveRecord::Migration
  def change
    add_column :study_notes, :starting_verse, :string
    add_column :study_notes, :ending_verse, :string
  end
end
