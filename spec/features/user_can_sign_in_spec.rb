require 'rails_helper'

RSpec.feature "User signs in", type: :feature do

  before :each do
    logout(:user)
  end

  context 'the user already exists' do
    before :all do
      @user = FactoryGirl.create :user
    end

    scenario 'they can sign in successfully' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      click_on 'Sign In'
      expect( page ).to have_content 'Dashboard'
    end

    context 'the login form is not valid' do
      scenario 'they see a helpful error message' do
        visit new_user_session_path
        fill_in 'user_email', with: @user.email
        click_on 'Sign In'
        expect( page ).to have_content 'Invalid Email or password'
      end
    end

  end

  context 'the user does not exist' do
    scenario 'they see a helpful error message' do
      user = FactoryGirl.build :user
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'Sign In'
      expect( page ).to have_content 'Invalid Email or password'
    end
  end
end
