class Order < ApplicationRecord
  def apply_coupon(informed_coupon)
    self.coupon = informed_coupon.key
    self.price = price.to_f - informed_coupon.value
    save
  end
end
