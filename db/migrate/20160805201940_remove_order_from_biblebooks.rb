# frozen_string_literal: true
class RemoveOrderFromBiblebooks < ActiveRecord::Migration[4.2]
  def change
    remove_column :biblebooks, :order, :integer
  end
end
