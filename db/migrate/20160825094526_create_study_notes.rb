class CreateStudyNotes < ActiveRecord::Migration
  def change
    create_table :study_notes do |t|
      t.references :pericope, index: true, foreign_key: true
      t.text :note

      t.timestamps null: false
    end
  end
end
