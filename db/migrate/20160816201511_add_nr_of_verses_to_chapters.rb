class AddNrOfVersesToChapters < ActiveRecord::Migration[4.2]
  def change
    add_column :chapters, :NrOfVerses, :integer
  end
end
