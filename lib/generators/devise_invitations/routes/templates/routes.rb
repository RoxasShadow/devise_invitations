
  devise_scope :user do
    get 'invitation/accept', to: 'invitations#accept', as: :accept_invitation_request
  end
