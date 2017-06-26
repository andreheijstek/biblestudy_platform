class AddOrderToBiblebooks < ActiveRecord::Migration[4.2]
  def change
    add_column :biblebooks, :order, :integer
  end
end
