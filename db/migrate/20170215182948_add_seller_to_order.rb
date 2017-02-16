class AddSellerToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :seller_id, :integer
  end
end
