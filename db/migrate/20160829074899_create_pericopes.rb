# frozen_string_literal: true
class CreatePericopes < ActiveRecord::Migration[4.2]
  def change
    create_table :pericopes do |t|
      t.belongs_to :studynote, index: true, foreign_key: true
      t.integer :starting_verse
      t.integer :ending_verse
      t.references :biblebook, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
