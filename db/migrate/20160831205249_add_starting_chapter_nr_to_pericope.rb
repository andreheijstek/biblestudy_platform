# frozen_string_literal: true

# Redesign - the old model had a Chapter Model, now it only contains a chapter_nr
class AddStartingChapterNrToPericope < ActiveRecord::Migration[4.2]
  def change
    add_column :pericopes, :starting_chapter_nr, :integer
  end
end
