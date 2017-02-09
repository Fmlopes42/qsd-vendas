class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :product
      t.string :plan
      t.string :price
      t.string :period
      t.string :coupon

      t.timestamps
    end
  end
end
