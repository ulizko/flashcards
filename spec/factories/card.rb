FactoryGirl.define do
  factory :card, class: Card do |m|
    original_text 'car'
    translated_text 'машина'
  end
end