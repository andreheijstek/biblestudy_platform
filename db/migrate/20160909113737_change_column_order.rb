# frozen_string_literal: true

class ChangeColumnOrder < ActiveRecord::Migration[4.2]
  def change
    def up
      change_table :biblebooks do |t|
        t.change :testament, :text, after: :name
        t.change :booksequence, :integer, after: :testament
      end
      change_table :chapters do |t|
        t.change :nrofverses, :integer, after: :description
      end
      change_table :pericopes do |t|
        t.change :name, :text, after: :id
        t.change :starting_chapter_nr, :integer, after: :name
        t.change :ending_chapter_nr, :integer, after: :starting_chapter_nr
      end
      change_table :study_notes do |t|
        t.change :title, :text, after: :id
      end
    end
  end
end
