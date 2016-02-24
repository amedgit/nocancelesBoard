class AddFechaToOcios < ActiveRecord::Migration
  def change
    add_column :ocios, :fecha, :datetime
  end
end
