class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits do |t|
      t.references :payment, foreign_key: true
      t.string :card_name
      t.string :card_number
      t.string :card_validity
      t.string :card_ccv

      t.timestamps
    end
  end
end
