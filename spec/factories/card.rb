FactoryGirl.define do
  factory :card, class: Card do
    original_text 'car'
    translated_text 'машина'
    
    after(:build) { |card| card.class.skip_callback(:create, :before, :set_review_date) }
  end
end
