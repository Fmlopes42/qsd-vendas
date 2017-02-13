require 'rails_helper'

RSpec.describe 'Order management', type: :request do
  it 'has one after choosing plan' do
    get '/hospedagem/premium/mensal/25'
    expect(Order.count).to eq 1
  end
end
