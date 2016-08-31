class RemoveStartingChapterIdFromPericope < ActiveRecord::Migration
  def change
    remove_column :pericopes, :starting_chapter_id, :integer
  end
end
