class AddCityToAlojamientos < ActiveRecord::Migration
  def change
    add_column :alojamientos, :city, :string
  end
end
