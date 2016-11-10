class AddAbbreviationToBiblebooks < ActiveRecord::Migration
  def change
    add_column :biblebooks, :abbreviation, :string
  end
end
