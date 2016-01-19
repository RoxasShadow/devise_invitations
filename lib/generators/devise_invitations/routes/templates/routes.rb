
  devise_scope :user do
    get 'invitation/accept',
      to: 'devise_invitations/invitations#accept',
      as: :accept_invitation_request
  end
