class CreateStudyNotes < ActiveRecord::Migration
  def change
    create_table :study_notes do |t|
      t.text :note

      t.timestamps null: false
    end
  end
end
