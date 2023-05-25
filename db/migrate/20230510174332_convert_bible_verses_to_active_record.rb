# frozen_string_literal: true

class ConvertBibleVersesToActiveRecord < ActiveRecord::Migration[7.0]
  def up
    # Convert existing PORO objects to ActiveRecord objects
    Pericope.find_each do |pericope|
      start_verse =
        BibleVerse.find_or_create_by(
          chapter: pericope.starting_chapter_nr,
          verse: pericope.starting_verse
        )

      end_verse =
        BibleVerse.find_or_create_by(
          chapter: pericope.ending_chapter_nr,
          verse: pericope.ending_verse
        )

      pericope.update(start_verse:, end_verse:)
    end

    # Remove old columns
    # remove_column :pericopes, :ending_chapter_nr
    # remove_column :pericopes, :ending_verse
    # remove_column :pericopes, :starting_chapter_nr
    # remove_column :pericopes, :starting_verse
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
