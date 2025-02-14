FactoryBot.define do
  factory :comment do
    text { "MyText" }
    project { nil }
    user { nil }
  end
end
