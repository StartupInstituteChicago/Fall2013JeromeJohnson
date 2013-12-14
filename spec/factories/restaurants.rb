FactoryGirl.define do
  factory :restaurant do
    name "Fancy Feast"
    description "A restaurant"
    address "123 N. Main St"
    phone_number "123.456.7890"
    owner
  end
end
