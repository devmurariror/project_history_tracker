FactoryBot.define do
  factory :project do
    title { "Sample Project" }
    description { "This is a sample project" }
    status { :in_progress }
    association :user
  end
end
