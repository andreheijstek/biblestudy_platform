class CreateStudyNotes < ActiveRecord::Migration
  def change
    create_table :studynotes do |t|
      t.text :note

      t.timestamps null: false
    end
  end
end
