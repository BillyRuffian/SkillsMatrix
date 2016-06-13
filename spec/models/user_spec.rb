require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validations' do
    it { is_expected.to validate_presence_of( :name ) }
    it { is_expected.to validate_presence_of( :email ) }
    it { is_expected.to validate_uniqueness_of( :email ).ignoring_case_sensitivity }
  end

  context 'associations' do
    it { is_expected.to have_many :claims }
    it { is_expected.to have_many :recommended_skills }
    it { is_expected.to have_many :skills_claimed }
    it { is_expected.to have_many( :leads ).with_foreign_key 'user_id' }
    it { is_expected.to have_and_belong_to_many :teams }
  end

  it 'must have DVLA digital or GSI email address' do
    expect( FactoryGirl.build( :user, email: 'foo@bar.com' ) ).not_to be_valid
  end

  context 'when first created' do
    it 'notifies administrators' do
      #allow( User ).to receive( :notify_administrators )
      user = FactoryGirl.build :user
      allow( user ).to receive( :notify_administrators )
      user.save
      user.run_callbacks :commit
      expect( user ).to have_received( :notify_administrators )
    end
  end

end
