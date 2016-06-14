FactoryGirl.define do
  factory :skill do
    sequence :name do |n|
      "#{Faker::Company.name}.#{n}"
    end
  end
end
