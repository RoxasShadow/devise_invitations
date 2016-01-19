
  has_many :invitations, class_name: 'DeviseInvitations::Invitation',
    foreign_key: :sent_by_id, dependent: :destroy
