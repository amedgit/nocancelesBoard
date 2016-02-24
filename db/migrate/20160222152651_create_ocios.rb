class CreateOcios < ActiveRecord::Migration
  def change
    create_table :ocios do |t|
      t.string :cat
      t.string :title
      t.text :desc
      t.string :dir
      t.integer :price
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
