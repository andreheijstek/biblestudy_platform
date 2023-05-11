# frozen_string_literal: true

class RemoveBibleVerse < ActiveRecord::Migration[7.0]
  def change
    drop_table :bible_verses, force: :cascade
  end
end
