FactoryGirl.define do
  factory :order do
    status 'opened'
    product 'Hospedagem'
    plan 'Premium'
    price 15.00
    period 'Mensal'
    coupon 'hosP_3xKy72'
    source_ip '0.0.0.0'
    payment nil
    user nil
  end
end
