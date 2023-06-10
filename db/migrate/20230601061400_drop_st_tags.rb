class DropStTags < ActiveRecord::Migration[7.0]
  def change
    drop_table :st_tags, force: :cascade
  end
end
