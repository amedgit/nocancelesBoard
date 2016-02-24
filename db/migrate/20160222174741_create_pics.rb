class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps null: false
    end
  end
end
