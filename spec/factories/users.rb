FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { "#{Faker::Internet.user_name}@digital.dvla.gov.uk" }
    password 'password'

    factory :administrator do
      admin true
    end
  end
end
