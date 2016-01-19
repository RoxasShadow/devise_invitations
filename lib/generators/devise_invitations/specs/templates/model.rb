require 'rails_helper'

RSpec.describe DeviseInvitations::Invitation do
  it { is_expected.to belong_to :sent_by }

  let(:valid) { build(:invitation) }
  it { expect(valid.pending?).to be_truthy }
  it { expect(valid.valid?).to be_truthy }

  let(:invalid) { build(:invitation, email: 'lolwut') }
  it { expect(invalid.valid?).to be_falsy }

  context 'use an email that is already registered inside the platform' do
    before  { create(:user, email: 'joe@example.com') }
    subject { create(:invitation, email: 'joe@example.com') }

    it 'raises an error' do
      expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
