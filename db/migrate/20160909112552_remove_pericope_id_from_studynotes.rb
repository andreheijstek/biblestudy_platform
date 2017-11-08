# frozen_string_literal: true

class RemovePericopeIdFromStudynotes < ActiveRecord::Migration[4.2]
  def change
    remove_column :studynotes, :pericope_id, :integer
  end
end
