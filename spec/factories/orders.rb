FactoryGirl.define do
  factory :order do
    product 'Hospedagem'
    plan 'Premium'
    price '15'
    period 'Mensal'
    coupon 'hosP_3xKy72'
  end
end
