class DeviseInvitations::Mailer < ApplicationMailer
  def instructions(invitation)
    @token    = invitation.token
    @sender   = invitation.sent_by
    @app_name = app_name

    mail(
      subject: t('.subject'),
      from:    @sender.email,
      to:      invitation.email,
    )
  end

  private

  def app_name
    Rails.application.class.parent_name
      .underscore
      .humanize
      .split
      .map(&:capitalize)
      .join(' ')
  end
end
