class CreateStudynoteTags < ActiveRecord::Migration[7.0]
  def change
    create_table :studynote_tags do |t|
      t.references :studynote, foreign_key: true
      t.references :st_tag, foreign_key: true

      t.timestamps
    end
  end
end
