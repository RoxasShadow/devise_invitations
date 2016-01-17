class InvitationsController < Devise::InvitationsController
  def accept
    invitation = Invitation.pending.find_by(token: params[:token])

    if invitation.present? && invitation.valid?
      invitation_params = { email: invitation.email }

      user = User.invite!(invitation_params, invitation.sent_by) do |u|
        u.skip_invitation = true
      end

      user.update(invitation_sent_at: Time.now.utc)

      statuses = Invitation.statuses
      invitation.update(status: statuses[:accepted])
      Invitation.pending.where(email: invitation.email).update_all(status: statuses[:ignored])

      redirect_to accept_invitation_url(user, invitation_token: user.raw_invitation_token)
    else
      flash[:error] = t('en.invitations.accept.not_valid')
      redirect_to root_path
    end
  end
end
