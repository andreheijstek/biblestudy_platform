class AddStartingChapterNrToPericope < ActiveRecord::Migration
  def change
    add_column :pericopes, :starting_chapter_nr, :integer
  end
end
