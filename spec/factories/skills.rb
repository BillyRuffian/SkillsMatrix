FactoryGirl.define do
  factory :skill do
    sequence :name do |n|
      Faker::Company.name
    end
  end
end
