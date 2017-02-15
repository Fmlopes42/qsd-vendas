class Payment < ApplicationRecord
  belongs_to :order
  has_one :boleto
  has_one :credit
end
