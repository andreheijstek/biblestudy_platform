# frozen_string_literal: true

class AddEndingChapterNrToPericope < ActiveRecord::Migration[4.2]
  def change
    add_column :pericopes, :ending_chapter_nr, :integer
  end
end
