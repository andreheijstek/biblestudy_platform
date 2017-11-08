# frozen_string_literal: true

class AddSequenceToBiblebooks < ActiveRecord::Migration[4.2]
  def change
    add_column :biblebooks, :sequence, :integer
  end
end
