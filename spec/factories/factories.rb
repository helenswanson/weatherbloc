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
    profile_photo { File.open(File.join(Rails.root, '/spec/support/example.jpg')) }
  end

  factory :event do
    sequence(:title) { |n| "Event #{n}" }
    description 'This is an event.'
    available_seats 3
    start_time Time.now
    end_time Time.now + (60 * 60 * 2)

    association :host, factory: :user
  end

  factory :category do
    name 'Movies'
  end

  factory :categorization do
    event
    category
  end

  # check_box event.categorization.category.name
end
