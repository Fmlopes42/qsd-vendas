FactoryGirl.define do
  factory :order do
    product 'Hospedagem'
    plan 'Premium'
    price '15'
    period 'Mensal'
    coupon 'hosP_3xKy72'
    source_ip '0.0.0.0'
    user nil
  end
end
