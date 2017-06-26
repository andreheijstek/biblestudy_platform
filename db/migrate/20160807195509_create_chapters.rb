class CreateChapters < ActiveRecord::Migration[4.2]
  def change
    create_table :chapters do |t|
      t.integer :chapter_number
      t.string :description
      t.references :biblebook, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
