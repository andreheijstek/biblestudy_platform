class AddTitleToStudynote < ActiveRecord::Migration[4.2]
  def change
    add_column :studynotes, :title, :string
  end
end
