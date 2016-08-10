class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.integer :verse_number
      t.string :verse_text
      t.references :chapter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
