FactoryGirl.define do
  factory :user do
    username 'admin'
    email 'admin@example.com'
    password '1234'
    password_confirmation '1234'
    admin true
  end
end
