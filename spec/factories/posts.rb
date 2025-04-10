FactoryBot.define do
  factory :post do
    title { 'Sample Post Title' }
    description { 'This is a sample post description' }
    body { 'This is the main content of the post. It can be quite long and detailed.' }
    author { 'John Doe' }
    association :user
  end
end 