class AddStudynoteToRoles < ActiveRecord::Migration[5.1]
  def change
    add_reference :roles, :studynote, foreign_key: true
  end
end
