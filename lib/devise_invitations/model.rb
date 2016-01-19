class DeviseInvitations::Invitation < ActiveRecord::Base
  belongs_to :sent_by, class_name: 'User', foreign_key: 'sent_by_id'
  has_secure_token :token

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :email, :sent_by, uniqueness: { scope: [:email, :sent_by] }
  validate :presence_as_user, on: :create

  enum status: [:pending, :accepted, :ignored]

  after_create { DeviseInvitations::Mailer.instructions(self).deliver_later }

  private

  def presence_as_user
    errors.add(:email, :user_already_exists) if User.exists?(email: email)
  end
end
