class AddTitleToStudyNote < ActiveRecord::Migration
  def change
    add_column :study_notes, :title, :string
  end
end
