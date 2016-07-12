FactoryGirl.define do
  factory :card, class: Card do
    original_text 'car'
    translated_text 'машина'
    user
    image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/image.jpg'))) }
    deck
    repeat 0
    efactor 2.5
    quality 0
    interval 0
  end
end
