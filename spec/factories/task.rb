FactoryGirl.define do

  factory :task do
    association :project, factory: :project
    title Faker::Company.bs
    completed false
  end

end