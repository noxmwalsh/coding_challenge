FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    body { Faker::Lorem.paragraph(sentence_count: 10) }
    hero_image_url { 'https://placedog.net/500/280' }
    author { Faker::Internet.email }
    user
  end
end
