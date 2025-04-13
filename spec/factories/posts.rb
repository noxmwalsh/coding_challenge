FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    body { Faker::Lorem.paragraph(sentence_count: 10) }
    author { Faker::Internet.email }
    user

    trait :with_hero_image do
      after(:build) do |post|
        post.hero_image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg')),
          filename: 'test.jpg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
end
