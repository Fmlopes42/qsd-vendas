class Order < ApplicationRecord
  def apply_coupon(informed_coupon)
    self.coupon = informed_coupon.key

    if informed_coupon.type == 'fixed'
      self.price = price.to_f - informed_coupon.value
    else
      self.price = price.to_f * (1 - (informed_coupon.value / 100.0))
    end

    save
  end
end
