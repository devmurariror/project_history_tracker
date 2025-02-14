FactoryBot.define do
  factory :comment do
    text { "This is a sample comment" }
    association :user
    association :project
  end
end
