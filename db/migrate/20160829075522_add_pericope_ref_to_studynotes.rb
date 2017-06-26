class AddPericopeRefToStudynotes < ActiveRecord::Migration[4.2]
  def change
    add_reference :studynotes, :pericope, index: true, foreign_key: true
  end
end
