class CreateBibleVerses < ActiveRecord::Migration[5.1]
  def change
    create_table :bible_verses do |t|
      t.references :biblebook, foreign_key: true
      t.integer :chapter_nr
      t.integer :verse_nr

      t.timestamps
    end
  end
end
