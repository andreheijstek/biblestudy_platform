class AddTitleToStudynote < ActiveRecord::Migration
  def change
    add_column :studynotes, :title, :string
  end
end
