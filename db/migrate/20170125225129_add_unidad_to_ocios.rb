class AddUnidadToOcios < ActiveRecord::Migration
  def change
    add_column :ocios, :unidad, :string ,default: "EURO"
  end
end
