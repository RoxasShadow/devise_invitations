require 'has_secure_token' unless Rails.version.start_with?('5')

if Rails.env.test?
  require 'shoulda-matchers'
  require 'faker'
end

require 'devise_invitations/engine'

module DeviseInvitations
  autoload :Mailer,                'devise_invitations/mailer'
  autoload :InvitationsController, 'devise_invitations/controller'
  autoload :Invitation,            'devise_invitations/model'
end
