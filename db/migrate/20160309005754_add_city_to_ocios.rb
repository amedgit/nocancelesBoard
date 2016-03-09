class AddCityToOcios < ActiveRecord::Migration
  def change
    add_column :ocios, :city, :string
  end
end
