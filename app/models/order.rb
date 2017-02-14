class Order < ApplicationRecord
  belongs_to :user, optional: true

  enum status: [:opened, :closed, :canceled]

  def apply_coupon(informed_coupon)
    self.coupon = informed_coupon.key

    if informed_coupon.type == 'fixed'
      self.price = price.to_f - informed_coupon.value
    else
      self.price = price.to_f * (1 - (informed_coupon.value / 100.0))
    end

    save
  end

  def check_integrity?(request_ip, request_user)
    if user.nil? && source_ip == request_ip
      update(user: request_user)
      true
    elsif user.nil? && source_ip != request_ip
      false
    else
      true
    end
  end

  def valid_user?(request_user)
    user == request_user
  end
end
