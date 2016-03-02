class DeviseInvitations::Mailer < ApplicationMailer
  def instructions(invitation)
    @token    = invitation.token
    @sender   = invitation.sent_by
    @app_name = app_name

    mail(
      subject: t('.subject'),
      from:    sender_email,
      to:      invitation.email,
    )
  end

  protected

  def sender_email
    @sender.email
  end

  def app_name
    Rails.application.class.parent_name
      .underscore
      .humanize
      .split
      .map(&:capitalize)
      .join(' ')
  end
end
