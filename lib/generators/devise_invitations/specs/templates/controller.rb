require 'rails_helper'

RSpec.describe InvitationsController do
  describe 'GET #accept' do
    before { @request.env['devise.mapping'] = Devise.mappings[:user] }

    let(:email) { Faker::Internet.safe_email }
    let(:user)  { User.find_by(email: email) }

    let(:joe)    { create(:user) }
    let(:sender) { create(:user) }
    let(:jack)   { create(:user) }

    let!(:joe_invitation)    { create(:invitation, email: email, sent_by: joe) }
    let!(:sender_invitation) { create(:invitation, email: email, sent_by: sender) }
    let!(:jack_invitation)   { create(:invitation, email: email, sent_by: jack) }

    context 'token is valid' do
      subject { get :accept, token: sender_invitation.token }

      it { is_expected.to have_http_status(302) }

      it 'creates a new user' do
        expect { subject }.to change { User.unscoped.find_by(email: email).class }
          .from(NilClass)
          .to(User)
      end

      it 'sets a invited_by attribute to the new user' do
        subject
        expect(user.invited_by).to eq sender
      end

      it 'flags as accepted the current invitation' do
        expect { subject }.to change { sender_invitation.reload.status }
          .from('pending')
          .to('accepted')
      end

      it 'flags as ignored the remanining invitations' do
        expect { subject }.to change { joe_invitation.reload.status }
          .from('pending')
          .to('ignored')
      end

      it 'does not accept additional requests' do
        subject

        expect { get :accept, token: sender_invitation.token }
          .to change { flash[:error] }
          .from(nil)
          .to(I18n.t('en.invitations.accept.not_valid'))
      end
    end

    context 'token is valid' do
      subject { get :accept, token: 'lolwut' }

      it { is_expected.to have_http_status(302) }

      it 'generates a flash error' do
        subject
        expect(flash[:error]).to eq I18n.t('en.invitations.accept.not_valid')
      end

      it 'does not create any new user' do
        expect { subject }.to_not change { User.unscoped.count }
      end
    end
  end
end
