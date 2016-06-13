require "rails_helper"

RSpec.describe Admin::AdminMailer, type: :mailer do
  describe '#new_registration_email' do
    before :all do
      # make sure there is at least one admin
      @administrator = FactoryGirl.create( :administrator )
    end

    it 'sends a notification to administrators' do
      user = FactoryGirl.build :user
      email = Admin::AdminMailer.new_registration_email( user )

      expect( email ).to bcc_to( User.administrators )
      expect( email ).to have_subject( "SkillsMatrix: new user #{user.name}" )
      expect( email ).to have_body_text( /#{user.name}/ )
      expect( email ).to have_body_text( /has created a SkillsMatrix account/ )
    end
  end
end
