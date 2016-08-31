class RemoveEndingChapterIdFromPericope < ActiveRecord::Migration
  def change
    remove_column :pericopes, :ending_chapter_id, :integer
  end
end
