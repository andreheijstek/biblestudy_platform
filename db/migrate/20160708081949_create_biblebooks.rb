class CreateBiblebooks < ActiveRecord::Migration
  def change
    create_table :biblebooks do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
