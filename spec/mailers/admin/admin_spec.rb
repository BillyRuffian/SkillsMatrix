require "rails_helper"

RSpec.describe Admin::AdminMailer, type: :mailer do
  describe '#new_registration_email' do
    it 'sends a notification to administrators' do
      @administrator = FactoryGirl.create( :administrator )
      user = FactoryGirl.build :user
      email = Admin::AdminMailer.new_registration_email( user )

      expect( email ).to bcc_to( User.administrators )
      expect( email ).to have_subject( "SkillsMatrix: new user #{user.name}" )
      expect( email ).to have_body_text( /#{user.name}/ )
      expect( email ).to have_body_text( /has created a SkillsMatrix account/ )
    end
  end

  describe '#teams_changed_email' do
    it 'sends a notification to the user when their team assignment is changed' do
      @administrator = FactoryGirl.create( :administrator )
      user = FactoryGirl.build :user
      team = FactoryGirl.build :team
      allow( user ).to receive( :teams ).and_return( [team] )

      email = Admin::AdminMailer.teams_changed_email( user, @administrator )

      expect( email ).to deliver_to user.email
      expect( email ).to have_subject( "SkillsMatrix: your team assignment has changed" )
      expect( email ).to have_body_text( team.name )
    end
  end
end
