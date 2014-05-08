FactoryGirl.define do

  factory :project do
    title Faker::Company.bs
    description Faker::Lorem.paragraph
  end

end

