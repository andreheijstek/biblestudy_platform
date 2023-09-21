# frozen_string_literal: true

class CreateBibleVerses < ActiveRecord::Migration[7.0]
  def change
    create_table :bible_verses do |t|
      t.integer :chapter
      t.integer :verse
      t.references :biblebook, foreign_key: true

      t.timestamps
    end
  end
end
