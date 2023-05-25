# frozen_string_literal: true

class AddStartVerseAndEndVerseReferencesToPericopes < ActiveRecord::Migration[
  6.1
]
  def change
    add_reference :pericopes,
                  :start_verse,
                  foreign_key: {
                    to_table: :bible_verses
                  }
    add_reference :pericopes,
                  :end_verse,
                  foreign_key: {
                    to_table: :bible_verses
                  }
  end
end
