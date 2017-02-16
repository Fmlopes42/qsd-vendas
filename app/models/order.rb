class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_one :payment

  enum status: [:opened, :closed, :canceled]

  def apply_coupon(informed_coupon)
    self.coupon = informed_coupon.key
    self.price = if informed_coupon.type.eql? 'fixed'
                   price - informed_coupon.value
                 else
                   price * calculate_percent(informed_coupon.value)
                 end
    self.price = 0 if price.negative?
    save
  end

  def check_integrity?(request_ip, request_user)
    if user.nil? && source_ip == request_ip
      update(user: request_user)
      true
    elsif user.nil? && source_ip != request_ip
      false
    else
      valid_user?(request_user)
    end
  end

  def valid_user?(request_user)
    user == request_user
  end

  private

  def calculate_percent(percent)
    (1 - (percent / 100.0))
  end
end
