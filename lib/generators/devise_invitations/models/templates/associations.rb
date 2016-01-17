
  has_many :invitations, foreign_key: :sent_by_id, dependent: :destroy
