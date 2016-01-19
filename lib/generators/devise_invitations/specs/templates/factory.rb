FactoryGirl.define do
  factory :invitation, class: DeviseInvitations::Invitation do
    email { Faker::Internet.safe_email }
    token { Devise.token_generator.generate(DeviseInvitations::Invitation, :token) }
    association :sent_by, factory: :user
  end
end
