class AddSourceIpToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :source_ip, :string
  end
end
