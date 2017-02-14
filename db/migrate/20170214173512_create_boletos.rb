class CreateBoletos < ActiveRecord::Migration[5.0]
  def change
    create_table :boletos do |t|
      t.references :payment, foreign_key: true

      t.timestamps
    end
  end
end
