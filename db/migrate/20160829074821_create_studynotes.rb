class CreateStudynotes < ActiveRecord::Migration[4.2]
  def change
    create_table :studynotes do |t|
      t.text :note

      t.timestamps null: false
    end
  end
end
