class AddAuthorToStudynotes < ActiveRecord::Migration[4.2]
  def change
    add_reference :studynotes, :author, index: true
    add_foreign_key :studynotes, :users, column: :author_id
  end
end
