# frozen_string_literal: true
class AddAbbreviationToBiblebooks < ActiveRecord::Migration[4.2]
  def change
    add_column :biblebooks, :abbreviation, :string
  end
end
