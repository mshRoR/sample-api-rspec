FactoryBot.define do
  factory :comment do
    article_id { Faker::Number.number(digits: 10) }
    body { Faker::Lorem.paragraph(sentence_count: 1) }
  end
end
