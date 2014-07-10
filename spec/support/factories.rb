FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    first_name 'John'
    last_name 'Smith'
    street_address '1234 Main St'
    city 'Cambridge'
    state 'MA'
    zip_code '02139'
    about 'I am nice.'
    # profile_photo
  end
end
