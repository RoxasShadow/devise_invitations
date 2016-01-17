FactoryGirl.define do
  factory :invitation do
    email { Faker::Internet.safe_email }
    token { Devise.token_generator.generate(Invitation, :token) }
    association :sent_by, factory: :user
  end
end
