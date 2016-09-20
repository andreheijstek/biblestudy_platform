class AddPericopeRefToStudynotes < ActiveRecord::Migration
  def change
    add_reference :studynotes, :pericope, index: true, foreign_key: true
  end
end
