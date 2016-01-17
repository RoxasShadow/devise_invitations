class InvitationMailer < ApplicationMailer
  def instructions(invitation)
    @token  = invitation.token
    @sender = invitation.sent_by

    mail(
      subject: t('.subject'),
      from:    @sender.email,
      to:      invitation.email,
    )
  end
end
