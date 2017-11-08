# frozen_string_literal: true
class ChangeNrofVersesTonrofverses < ActiveRecord::Migration[4.2]
  def change
    rename_column :chapters, :NrOfVerses, :nrofverses
  end
end
