FactoryBot.define do
  factory :user do
    first_name  {Faker::Name.name}
    last_name   {Faker::Name.name}
    email       {Faker::Internet.email}
    status      {true}
  end
end