require 'rails_helper'

RSpec.feature "User creates an account", type: :feature do

  before :each do
    logout(:user)
  end
  
  scenario 'they are taken to the dashboard' do
    user = FactoryGirl.build :user
    visit new_user_registration_path
    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password

    click_on 'Register'

    expect( page ).to have_content 'Dashboard'
  end

  context 'the signup form is not valid' do
    scenario 'they see an error message' do
      user = FactoryGirl.build :user
      visit new_user_registration_path
      # do not fill in user name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password

      click_on 'Register'

      expect( page ).to have_content 'Name can\'t be blank'
    end
  end
end
