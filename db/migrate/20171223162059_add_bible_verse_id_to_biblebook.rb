class AddBibleVerseIdToBiblebook < ActiveRecord::Migration[5.1]
  def change
    add_column :biblebooks, :bible_verse_id, :bigint
  end
end
