class AddUnidadToAlojamientos < ActiveRecord::Migration
  def change
    add_column :alojamientos, :unidad, :string , default: "EURO"
  end
end
