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
end
