# frozen_string_literal: true
class RemoveSequenceFromBiblebooks < ActiveRecord::Migration[4.2]
  def change
    remove_column :biblebooks, :sequence, :integer
  end
end
