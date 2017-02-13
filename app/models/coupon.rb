class Coupon
  VALIDS_COUPONS = {
    cp001: { type: 'fixed', value: 50 },
    cpr001: { type: 'percent', value: 10 }
  }.freeze

  attr_reader :key, :value, :type
  def initialize(params)
    @key = params[:key]
    @type = params[:type]
    @value = params[:value]
  end

  def self.find(key)
    return unless VALIDS_COUPONS[key.to_sym]
    new key: key,
        type: VALIDS_COUPONS[key.to_sym][:type],
        value: VALIDS_COUPONS[key.to_sym][:value]
  end
end
