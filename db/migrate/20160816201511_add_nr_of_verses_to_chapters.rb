class AddNrOfVersesToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :NrOfVerses, :integer
  end
end
