class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.string :cat
      t.string :title
      t.text :desc
      t.string :from_city
      t.string :to_city
      t.integer :price
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
