class CreateAlojamientos < ActiveRecord::Migration
  def change
    create_table :alojamientos do |t|
      t.string :cat
      t.string :title
      t.string :dir
      t.datetime :fecha_ir
      t.datetime :fecha_volver
      t.text :desc
      t.integer :user_id
      t.integer :price

      t.timestamps null: false
    end
  end
end
