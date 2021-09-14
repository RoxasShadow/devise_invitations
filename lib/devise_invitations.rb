require 'devise_invitations/engine'

module DeviseInvitations
  autoload :Mailer,                'devise_invitations/mailer'
  autoload :InvitationsController, 'devise_invitations/controller'
  autoload :Invitation,            'devise_invitations/model'
end
