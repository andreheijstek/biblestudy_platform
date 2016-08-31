class AddEndingChapterNrToPericope < ActiveRecord::Migration
  def change
    add_column :pericopes, :ending_chapter_nr, :integer
  end
end
