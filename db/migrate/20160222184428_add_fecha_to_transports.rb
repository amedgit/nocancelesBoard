class AddFechaToTransports < ActiveRecord::Migration
  def change
    add_column :transports, :fecha, :datetime
  end
end
