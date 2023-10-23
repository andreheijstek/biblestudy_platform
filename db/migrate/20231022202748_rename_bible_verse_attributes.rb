class RenameBibleVerseAttributes < ActiveRecord::Migration[7.0]
  # This looks really stupid, but was needed. There was a mismatch in db schema between
  # development and production. This got it in sync again
  def change
    if BibleVerse.column_names.include? "chapter_nr"
      rename_column :bible_verses, :chapter_nr, :chapter
    else
      rename_column :bible_verses, :chapter, :chapter_nr
    end

    if BibleVerse.column_names.include? "verse_nr"
      rename_column :bible_verses, :verse_nr, :verse
    else
      rename_column :bible_verses, :verse, :verse_nr
    end
  end
end
