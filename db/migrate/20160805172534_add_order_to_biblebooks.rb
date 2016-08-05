class AddOrderToBiblebooks < ActiveRecord::Migration
  def change
    add_column :biblebooks, :order, :integer
  end
end
