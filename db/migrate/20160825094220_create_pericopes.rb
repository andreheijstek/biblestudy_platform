class CreatePericopes < ActiveRecord::Migration
  def change
    create_table :pericopes do |t|
      t.integer :starting_verse
      t.integer :ending_verse
      t.references :biblebook, index: true, foreign_key: true
      t.references :starting_chapter, index: true, foreign_key: true
      t.references :ending_chapter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
