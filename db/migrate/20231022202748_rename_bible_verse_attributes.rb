class RenameBibleVerseAttributes < ActiveRecord::Migration[7.0]
  def change
    rename_column :bible_verses, :chapter_nr, :chapter
    rename_column :bible_verses, :verse_nr, :verse
    rename_column :bible_verses, :chapter, :chapter_nr
    rename_column :bible_verses, :verse, :verse_nr
  end
end
