class AddTestamentToBiblebooks < ActiveRecord::Migration[4.2]
  def change
    add_column :biblebooks, :testament, :string
  end
end
