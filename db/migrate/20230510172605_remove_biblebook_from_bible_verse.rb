class RemoveBiblebookFromBibleVerse < ActiveRecord::Migration[7.0]
  def change
    remove_column :bible_verses, :biblebook_id, :bigint

  end
end
