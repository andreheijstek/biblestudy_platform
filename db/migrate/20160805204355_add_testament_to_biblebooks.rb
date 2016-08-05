class AddTestamentToBiblebooks < ActiveRecord::Migration
  def change
    add_column :biblebooks, :testament, :string
  end
end
