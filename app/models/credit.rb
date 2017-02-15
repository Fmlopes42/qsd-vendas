class Credit < ApplicationRecord
  belongs_to :payment
  validates :card_name, :card_number, :card_validity, :card_ccv, presence: true
end
