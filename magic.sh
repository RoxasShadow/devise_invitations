##
# Hello, I'm a magical little girl in aid of CI-kun.
# I'll create and setup a new Rails application from scratch so CI-kun
# can test it. Bye-chi!
##

gem install rails

rails new test_app

cd test_app

echo "gem 'sqlite3'
gem 'rspec-rails'
gem 'factory_girl_rails'
gem 'devise'
gem 'devise_invitable'
gem 'devise_invitations', path: '../'
" >> Gemfile

echo "`sed '45d' Gemfile`" > Gemfile # spring a shit

bundle install

rails g rspec:install

# we need a root_path
rails g controller welcome index
contents="root 'welcome#index'"
echo "`sed \"8s/^/$contents/\" config/routes.rb`" > config/routes.rb

rails g model user
rails g mailer UserMailer # we need an ApplicationMailer too

rails g devise:install
rails g devise user

rails g devise_invitable:install
rails g devise_invitable user

## Uncomment these to check the diff later
# git init
# git add .
# git commit -m "Initial commit"

rails g devise_invitations:install
rails g devise_invitations:specs

rake db:migrate

# Enable FactoryGirl and Shoulda
echo "
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

" >> spec/rails_helper.rb

echo "FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password(8) }
  end
end
" > spec/factories/users.rb

contents="config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }"
echo "`sed \"39s/^/$contents/\" config/environments/test.rb`" > config/environments/test.rb
