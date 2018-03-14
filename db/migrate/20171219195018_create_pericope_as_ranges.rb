# frozen_string_literal: true

class CreatePericopeAsRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :pericope_as_ranges do |t|
      t.string :name
      t.references :starting_verse, index: true, foreign_key: { to_table: :bible_verses }
      t.references :ending_verse, index: true, foreign_key: { to_table: :bible_verses }

      t.timestamps
    end
  end
end
