# frozen_string_literal: true

class AddNameToPericope < ActiveRecord::Migration[4.2]
  def change
    add_column :pericopes, :name, :string
  end
end
