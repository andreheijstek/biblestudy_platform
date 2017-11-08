# frozen_string_literal: true
class AddBiblebookNameToPericopes < ActiveRecord::Migration[4.2]
  def change
    add_column :pericopes, :biblebook_name, :string
  end
end
