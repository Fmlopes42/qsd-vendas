FactoryGirl.define do
  factory :credit do
    payment
    card_name 'Joao S L'
    card_number '1234 1243 1234 1234'
    card_validity '12/21'
    card_ccv '123'
  end
end
