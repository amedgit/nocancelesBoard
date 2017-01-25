class AddUnidadToTransports < ActiveRecord::Migration
  def change
    add_column :transports, :unidad, :string , default: "EURO"
  end
end
