require_relative 'lib/devise_invitations/version.rb'

Gem::Specification.new do |s|
  s.name         = 'devise_invitations'
  s.version      = DeviseInvitations::VERSION
  s.platform     = Gem::Platform::RUBY
  s.author       = 'Roxas Shadow'
  s.email        = 'webmaster@giovannicapuano.net'
  s.homepage     = 'https://github.com/RoxasShadow/devise_invitations'
  s.summary      = 'Allow multiple invitations on top of devise_invitable'
  s.description  = 'Extend devise and devise_invitable allowing multiple invitations.'
  s.license      = 'BSD-2-Clause'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files specs`.split("\n")
  s.require_path = 'lib'

  s.add_dependency 'devise_invitable', '~> 1.5'
  s.add_dependency 'has_secure_token', '~> 1.0'
  s.add_dependency 'shoulda-matchers', '>= 2.8'
  s.add_dependency 'faker',            '~> 1.6'
end
