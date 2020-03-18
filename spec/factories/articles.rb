FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: 5) }
    description { Faker::Lorem.paragraphs(number: 3) }
  end
end
