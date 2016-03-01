class CreatePerfils < ActiveRecord::Migration
  def change
    create_table :perfils do |t|
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.integer :age
      t.string :gender
      t.integer :user_id
      t.string :facebook_link
      t.string :twitter_link
      t.string :website_link

      t.timestamps null: false
    end
  end
end
