class ChangeNrofVersesTonrofverses < ActiveRecord::Migration
  def change
    rename_column :chapters, :NrOfVerses, :nrofverses
  end
end
