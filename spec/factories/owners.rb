FactoryGirl.define do
  sequence(:email) { |e| "test#{e}@example.com" }

  factory :owner do
    name "Test User"
    email
    password "test1234"
  end

end
