# frozen_string_literal: true
class AddStartingChapterNrToPericope < ActiveRecord::Migration[4.2]
  def change
    add_column :pericopes, :starting_chapter_nr, :integer
  end
end
