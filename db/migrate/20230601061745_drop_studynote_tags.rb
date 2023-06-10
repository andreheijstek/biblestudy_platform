class DropStudynoteTags < ActiveRecord::Migration[7.0]
  def change
    drop_table :studynote_tags, force: :cascade
  end
end
