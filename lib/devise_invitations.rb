require 'has_secure_token' unless Rails.version.start_with?('5')

if Rails.env.test?
  require 'shoulda-matchers'
  require 'faker'
end
